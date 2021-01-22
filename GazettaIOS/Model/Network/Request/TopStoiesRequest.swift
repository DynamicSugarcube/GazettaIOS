//
//  TopStoiesRequest.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 22.01.2021.
//

import Foundation

struct TopStoriesRequest: NetworkRequestProtocol {
    var country: NewsApiCountry
    
    var endpoint: NewsApiEndpoint {
        return .topStories
    }
    
    func build() -> String {
        var request = NewsApiConstants.baseUrl
        request += endpoint.rawValue
        request += "?country=\(country.rawValue)"
        request += "&apiKey=\(NewsApiConstants.apiKey)"
        return request
    }
}
