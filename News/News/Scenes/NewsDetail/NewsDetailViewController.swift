//
//  NewsDetailViewController.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 25/5/2566 BE.
//

import UIKit
import SafariServices

class NewsDetailViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var readMoreButton: UIButton!
    
    var viewModel: NewsDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Details"
        setReadMoreButton()
        bindDetail()
    }
    
    func bindDetail() {
        let data = viewModel.getDetail()
        if let url = URL(string: data.imageURL ?? "") {
            imageView.af.setImage(withURL: url)
        }
        
        titleLabel.text = data.title
        contentLabel.text = data.content
        dateTimeLabel.text = data.dateTime
        
        readMoreButton.isHidden = viewModel.contentURL == nil
    }
    
    func setReadMoreButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributeString = NSMutableAttributedString(
            string: "Read More",
            attributes: attributes
        )
        readMoreButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    @IBAction func onTouchReadMoreButton() {
        if let url = viewModel.contentURL {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
}
