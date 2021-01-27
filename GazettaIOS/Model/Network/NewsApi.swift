//
//  NewsApi.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 20.01.2021.
//

import Foundation

enum NewsApiEndpoint: String {
    case topStories = "top-headlines"
    case latestNews = "everything"
}

enum NewsApiCountry: String {
    case usa = "us"
}

struct NewsApiConstants {
    static let baseUrl = "https://newsapi.org/v2/"
    static let apiKey = "d39508964e424b89a45684b7ec00eb6a"
}
