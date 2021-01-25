//
//  BookmarksViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import Foundation

class BookmarksViewModel: BookmarksDelegate {
    private var databaseInteractor: DatabaseInteractor
    
    init(databaseInteractor: DatabaseInteractor) {
        self.databaseInteractor = databaseInteractor
    }
    
    func getBookmarks(onComplete: @escaping ([NewsArticle]) -> Void) {
        databaseInteractor.getFromDatabase() { articles in
            onComplete(articles)
        }
    }
    
    func removeFromBookmarks(_ article: NewsArticle) -> Bool {
        return databaseInteractor.removeFromDatabase(article)
    }
}
