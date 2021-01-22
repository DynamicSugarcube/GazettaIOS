//
//  NewsApiResponse.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 20.01.2021.
//

import Foundation

struct NewsApiResponse: Decodable {
    let articles: [NewsArticle]?
}
