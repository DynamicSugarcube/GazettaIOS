//
//  DatabaseInteractor.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 24.01.2021.
//

import Foundation

protocol DatabaseService {
    func isInDatabase(_ newsArticle: NewsArticle) -> Bool
    func saveToDatabase(_ newsArticle: NewsArticle) -> Bool
    func removeFromDatabase(_ newsArticle: NewsArticle) -> Bool
    func getFromDatabase(onComplete: @escaping ([NewsArticle]) -> Void)
}
