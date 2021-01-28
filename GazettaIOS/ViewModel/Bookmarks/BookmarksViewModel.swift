//
//  BookmarksViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import Foundation

class BookmarksViewModel {
    let searchPlaceholder = "Search for bookmarks"
    let showNewsDetailsSegueId = "showNewsDetails"

    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }

    func getBookmarks(onComplete: @escaping () -> Void) {
        databaseService.getFromDatabase { [weak self] articles in
            guard let self = self else { return }
            self.bookmarks = articles
            onComplete()
        }
    }

    func filterBookmarks(for searchText: String) {
        filteredBookmarks = bookmarks.filter { article in
            article.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }

    func createViewModelForCell(indexOfArticle index: Int, isFiltering: Bool) -> NewsCellViewModel? {
        let dataSet = isFiltering ? filteredBookmarks : bookmarks

        if !dataSet.indices.contains(index) {
            print("Couldn't create a view model for index: \(index)")
            return nil
        }

        let article = dataSet[index]
        return NewsCellViewModel(article: article, delegate: self)
    }

    private var databaseService: DatabaseService

    private(set) var bookmarks: [NewsArticle] = []
    private(set) var filteredBookmarks: [NewsArticle] = []
}

// MARK: - BookmarksDelegate
extension BookmarksViewModel: BookmarksDelegate {
    func isBookmark(_ article: NewsArticle) -> Bool {
        return databaseService.isInDatabase(article)
    }

    func saveToBookmarks(_ article: NewsArticle) -> Bool {
        return databaseService.saveToDatabase(article)
    }

    func removeFromBookmarks(_ article: NewsArticle) -> Bool {
        return databaseService.removeFromDatabase(article)
    }
}
