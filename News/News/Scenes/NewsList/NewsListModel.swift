//
//  NewsListModel.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 23/5/2566 BE.
//

import Foundation

struct NewsListModel {
    var articles: [Article] = []
}

class NewsListRepository {
    func getNewsList(keyword: String? = nil, pageSize: Int, page: Int, completion: @escaping (NewsListModel) -> Void, failure: @escaping(String) -> Void) {
        let request = NewsListRequest(keyword: keyword, pageSize: pageSize, page: page)
        Network.getRequest(request: request) { (response: NewsListResponse) in
            if response.totalResults != 0 {
                let model = NewsListModel(articles: response.articles ?? [])
                completion(model)
            } else {
                failure("Data not found")
            }
        } failureBlock: { error in
            failure(error.localizedDescription)
        }
    }
}
