//
//  NewsListViewModel.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 23/5/2566 BE.
//

import UIKit

class NewsListViewModel {
    private let repository: NewsListRepository
    private var newsListModel: NewsListModel = NewsListModel()
    
    var page = 1
    var pageSize = 10
    var isCanLoadMore = true
    
    var newsList: [Article] {
        return newsListModel.articles
    }
    
    init() {
        self.repository = NewsListRepository()
    }
    
    func getNewsList(keyword: String? = nil, isReload: Bool = false, completion: @escaping([Article]) -> Void, failure: @escaping(String) -> Void) {
        if isReload {
            page = 1
            newsListModel.articles = []
        } else {
            page += 1
        }
        
        repository.getNewsList(keyword: keyword ,pageSize: pageSize, page: page, completion: { newsList in
            if !newsList.articles.isEmpty {
                self.newsListModel.articles += newsList.articles
                completion(self.newsListModel.articles)
            } else {
                self.isCanLoadMore = false
                completion(self.newsListModel.articles)
            }
        }) { errorMessage in
            failure(errorMessage)
        }
    }
    
    func getNewsDetailVC(indexItem: Int) -> NewsDetailViewController {
        let detailVM = NewsDetailViewModel(article: newsList[indexItem])
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        detailVC.viewModel = detailVM
        
        return detailVC
    }
}
