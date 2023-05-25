//
//  NewsListResponse.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 23/5/2566 BE.
//

import Foundation

// MARK: - NewsListResponse
struct NewsListResponse: Codable {
    let status: String?
    let code: String?
    let message: String?
    
    let totalResults: Int?
    let articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case code = "code"
        case message = "message"
        
        case totalResults = "totalResults"
        case articles = "articles"
    }
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    var dateTimeDisplay: String {
        guard let inputDateString = publishedAt else {
            return ""
        }

        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMM dd, HH:mm"

        if let inputDate = inputDateFormatter.date(from: inputDateString) {
            let outputDateString = outputDateFormatter.string(from: inputDate)
            return outputDateString
        } else {
            print("Invalid date string")
        }
        
        return ""
    }

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

