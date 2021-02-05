//
//  NewsArticle.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 20.01.2021.
//

import Foundation

struct NewsArticle {
    let publisher: String?
    let title: String?
    let newsUrl: String?
    let imageUrl: String?
    let when: Date?
}

// MARK: - Decodalbe
extension NewsArticle: Decodable {
    private enum ArticleCodingKeys: String, CodingKey {
        case title
        case newsUrl = "url"
        case imageUrl = "urlToImage"
        case when = "publishedAt"
        case source
    }

    private enum SourceCodingKeys: String, CodingKey {
        case publisher = "name"
    }

    init(from decoder: Decoder) throws {
        let articleInfo = try decoder.container(keyedBy: ArticleCodingKeys.self)
        title = try articleInfo.decode(String?.self, forKey: .title)
        newsUrl = try articleInfo.decode(String?.self, forKey: .newsUrl)
        imageUrl = try articleInfo.decode(String?.self, forKey: .imageUrl)
        when = try articleInfo.decode(Date?.self, forKey: .when)

        let sourceInfo = try articleInfo.nestedContainer(keyedBy: SourceCodingKeys.self, forKey: .source)
        publisher = try sourceInfo.decode(String?.self, forKey: .publisher)
    }
}
