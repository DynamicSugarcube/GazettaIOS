//
//  NetworkRequestProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 22.01.2021.
//

import Foundation

protocol NetworkRequest {
    var endpoint: NewsApiEndpoint { get }

    func build() -> String
}
