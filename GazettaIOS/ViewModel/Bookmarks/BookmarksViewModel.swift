//
//  BookmarksViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import Foundation

class BookmarksViewModel: BookmarksDelegate {
    private var databaseInteractor: DatabaseInteractor
    
    var dataSet: [NewsArticle] = []
    
    init(databaseInteractor: DatabaseInteractor) {
        self.databaseInteractor = databaseInteractor
    }
    
    func getBookmarks(onComplete: @escaping () -> Void) {
        databaseInteractor.getFromDatabase() { [weak self] articles in
            self?.dataSet = articles
            onComplete()
        }
    }
    
    func isBookmark(_ article: NewsArticle) -> Bool {
        return databaseInteractor.isInDatabase(article)
    }
    
    func saveToBookmarks(_ article: NewsArticle) -> Bool {
        return databaseInteractor.saveToDatabase(article)
    }
    
    func removeFromBookmarks(_ article: NewsArticle) -> Bool {
        return databaseInteractor.removeFromDatabase(article)
    }
    
    func createViewModelForCell(indexOfArticle index: Int) -> NewsTableViewCellViewModel? {
        if index >= dataSet.count || index < 0 {
            print("Couldn't create a view model for index: \(index)")
            return nil
        }
        let article = dataSet[index]
        return NewsTableViewCellViewModel(article: article, delegate: self)
    }
}
