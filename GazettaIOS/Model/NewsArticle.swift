//
//  NewsArticle.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 20.01.2021.
//

import Foundation

struct NewsArticle: Decodable {
    let publisher: String?
    let title: String?
    let newsUrl: String?
    let imageUrl: String?
    let when: Date?

    private enum CodingKeys: String, CodingKey {
        case publisher = "author"
        case title
        case newsUrl = "url"
        case imageUrl = "urlToImage"
        case when = "publishedAt"
    }
}
