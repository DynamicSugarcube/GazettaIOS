//
//  LatestNewsRequest.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 22.01.2021.
//

import Foundation

struct LatestNewsRequest: NetworkRequest {
    var endpoint: NewsApiEndpoint {
        return .latestNews
    }

    var keyword: String?

    func build() -> String {
        var request = NewsApiConstants.baseUrl
        request += endpoint.rawValue

        request += "?"

        if let keyword = keyword {
            request += "qInTitle=\(keyword)&"
        }

        let language = "en"
        request += "language=\(language)&"

        let currentDate = dateFormatter.string(from: Date())
        request += "to=\(currentDate)&"

        request += "apiKey=\(NewsApiConstants.apiKey)"
        return request
    }

    private let dateFormatter = ISO8601DateFormatter()
}
