//
//  LatestNewsRequest.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 22.01.2021.
//

import Foundation

struct LatestNewsRequest: NetworkRequestProtocol {
    var endpoint: NewsApiEndpoint {
        return .latestNews
    }
    
    // MARK: TODO Not implemented
    func build() -> String {
        return ""
    }
}
