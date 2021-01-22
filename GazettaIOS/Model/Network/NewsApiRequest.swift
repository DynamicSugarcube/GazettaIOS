//
//  NewsApiRequest.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 20.01.2021.
//

import Foundation

struct NewsApiRequest: DataRequestProtocol {
    var endpoint: NewsApiEndpoint
    var country: NewsApiCountry?
    
    init(endpoint: NewsApiEndpoint, country: NewsApiCountry? = nil) {
        self.endpoint = endpoint
        self.country = country
    }
    
    func build() -> String {
        var request = NewsApiConstants.baseUrl
        request += endpoint.rawValue
        if let country = self.country {
            request += "?country=\(country.rawValue)"
        }
        request += "&apiKey=\(NewsApiConstants.apiKey)"
        return request
    }
}
