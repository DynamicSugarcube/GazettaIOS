//
//  NetworkRequestProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 22.01.2021.
//

import Foundation

protocol NetworkRequestProtocol: DataRequestProtocol {
    var endpoint: NewsApiEndpoint { get }
}
