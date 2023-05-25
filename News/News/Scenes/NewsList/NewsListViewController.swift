//
//  NewsListViewController.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 23/5/2566 BE.
//

import UIKit
import NVActivityIndicatorView

class NewsListViewController: BaseViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataNotFound: UIView!
    
    private var viewModel: NewsListViewModel!
    
    private var loadMoreIndicatorView: NVActivityIndicatorView?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsListViewModel()
        initController()
        
        getNewsList(loadState: .reload)
    }
    
    @objc
    func doneButtonClicked(_ sender: Any) {
        getNewsList(loadState: .reload)
    }
    
    @objc
    func pullToRefresh() {
        getNewsList(loadState: .pullToRefresh)
    }
    
    private func initController() {
        searchTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        
        // Set Loadmore
        loadMoreIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), type: .ballClipRotate, color: Constants.bluePrimaryColor, padding: 0)

        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.tableFooterView?.frame.width ?? 0, height: 60))
        loadMoreIndicatorView?.center = footerView.center
        footerView.addSubview(loadMoreIndicatorView ?? UIView())
        
        tableView.tableFooterView = footerView
        
        // Set Pull to refresh
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func navigateToNewsDetail(indewItem: Int) {
        let vc = viewModel.getNewsDetailVC(indexItem: indewItem)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getNewsList(loadState: LoadStateEnum) {
        let keyword = searchTextField.text?.isEmpty ?? true ? nil : searchTextField.text
        
        if loadState == .reload {
            activityIndicatorView.startAnimating()
        } else if loadState == .loadMore {
            loadMoreIndicatorView?.startAnimating()
        }
        
        self.viewModel.getNewsList(keyword: keyword,
                                   isReload: loadState == .pullToRefresh || loadState == .reload) { _ in
            self.activityIndicatorView.stopAnimating()
            self.loadMoreIndicatorView?.stopAnimating()
            self.refreshControl.endRefreshing()
            
            self.bindData(list: self.viewModel.newsList)
            self.dataNotFound(isShow: false)
        } failure: { errorMessage in
            self.activityIndicatorView.stopAnimating()
            self.loadMoreIndicatorView?.stopAnimating()
            self.refreshControl.endRefreshing()
            
            if errorMessage == "Data not found" {
                self.dataNotFound(isShow: true)
            } else {
                print(errorMessage)
            }
        }
    }
    
    private func dataNotFound(isShow: Bool) {
        dataNotFound.isHidden = !isShow
        tableView.isHidden = isShow
    }
    
    private func bindData(list: [Article]) {
        tableView.reloadData()
    }

}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToNewsDetail(indewItem: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.newsList.count - 1, viewModel.isCanLoadMore {
            getNewsList(loadState: .loadMore)
        }
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.newsList[indexPath.row]
        cell.bindData(imageUrlString: data.urlToImage ?? "",
                      titleString: data.title ?? "",
                      detail: data.description ?? "",
                      dateTime: data.dateTimeDisplay)
        
        return cell
    }
    
    
}
