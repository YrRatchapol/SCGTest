//
//  NewsDetailViewModel.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 25/5/2566 BE.
//

import Foundation

class NewsDetailViewModel {
    private let repository: NewsDetailRepository
    private var newsDetailModel: NewsDetailModel = NewsDetailModel()
    
    private var article: Article?
    
    init(article: Article) {
        self.repository = NewsDetailRepository()
        self.article = article
        
        self.newsDetailModel.imageURL = article.urlToImage
        self.newsDetailModel.title = article.title
        self.newsDetailModel.content = article.content
        self.newsDetailModel.dateTime = article.dateTimeDisplay
    }
    
    func getDetail() -> NewsDetailModel {
        return newsDetailModel
    }
    
    var contentURL: URL? {
        return URL(string: article?.url ?? "")
    }
}
