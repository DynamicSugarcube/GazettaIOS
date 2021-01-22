//
//  DataRetrieverProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 20.01.2021.
//

import Foundation

protocol DataRetriever {
    func getNewsArticles(on request: DataRequestProtocol, onComplete: @escaping ([NewsArticle]) -> Void)
}
