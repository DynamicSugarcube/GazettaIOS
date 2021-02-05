//
//  BookmarksInteractor.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 03.02.2021.
//

import Foundation

class BookmarksInteractor {
    weak var output: BookmarksInteractorOutputProtocol?

    init(output: BookmarksInteractorOutputProtocol, databaseService: DatabaseService) {
        self.output = output
        self.databaseService = databaseService
    }

    private let databaseService: DatabaseService

    private var bookmarks: [NewsArticle] = []
    private var filteredBookmarks: [NewsArticle] = []
}

// MARK: - BookmarksInteractorInputProtocol
extension BookmarksInteractor: BookmarksInteractorInputProtocol {
    func loadBookmarks() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            self.databaseService.getFromDatabase { articles in
                self.bookmarks = articles
                self.output?.didLoadBookmarks(self.bookmarks)
            }
        }
    }

    func filterBookmarks(searchText: String) {
        let filtered = bookmarks.filter { article in
            article.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
        output?.didFilterBookmarks(filtered)
    }

    func getBookmarkForNavigation(at index: Int, isFiltering: Bool) {
        var bookmark: NewsArticle?
        if isFiltering {
            bookmark = filteredBookmarks.indices.contains(index) ? filteredBookmarks[index] : nil
        } else {
            bookmark = bookmarks.indices.contains(index) ? bookmarks[index] : nil
        }
        output?.didGetBookmarkForNavigation(bookmark)
    }
}

// MARK: - BookmarksDelegate
extension BookmarksInteractor: BookmarksDelegate {
    func isBookmark(_ article: NewsArticle) -> Bool {
        databaseService.isInDatabase(article)
    }

    func saveToBookmarks(_ article: NewsArticle) -> Bool {
        databaseService.saveToDatabase(article)
    }

    func removeFromBookmarks(_ article: NewsArticle) -> Bool {
        databaseService.removeFromDatabase(article)
    }
}
