//
//  NewsListRequest.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 23/5/2566 BE.
//

import Foundation
import Alamofire

class NewsListRequest: BaseRequestProtocol {
    let baseUrl: String = "https://newsapi.org/v2/everything"
    var url: String? {
        return "\(baseUrl)?apiKey=\(apiKey)&q=\(keyword)&sortBy=\(sortBy)&pageSize=\(pageSize)&page=\(page)"
    }
    
    let apiKey: String = "0972e15b7b8f498abe39cb261fde03bb"
    var keyword: String = "Apple"
    var sortBy: String = "publishedAt"
    var pageSize: Int = 20
    var page: Int = 1
    
    init(keyword: String?, pageSize: Int, page: Int) {
        self.keyword = keyword ?? self.keyword
        self.pageSize = pageSize
        self.page = page
    }
    
    var parameters: Parameters? { get { return nil } }
}
