//
//  NetworkDataRetrieverProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 20.01.2021.
//

import Foundation

protocol NetworkService {
    func getNewsArticles(on request: NetworkRequest, onComplete: @escaping ([NewsArticle]) -> Void)
}
