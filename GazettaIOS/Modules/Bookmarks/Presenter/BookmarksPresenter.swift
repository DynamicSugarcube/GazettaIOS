//
//  BookmarksPresenter.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 03.02.2021.
//

import Foundation

class BookmarksPresenter {
    weak var output: BooksmarksPresenterOutputProtocol?
    var interactor: BookmarksInteractorInputProtocol?
    var router: BookmarksRouterProtocol?

    init(output: BooksmarksPresenterOutputProtocol) {
        self.output = output
    }
}

// MARK: - BookmarksPresenterInputProtocol
extension BookmarksPresenter: BookmarksPresenterInputProtocol {
    func loadBookmarks(searchText: String?) {
        if let text = searchText {
            interactor?.filterBookmarks(searchText: text)
        } else {
            interactor?.loadBookmarks()
        }
    }

    func onClickCell(at index: Int, isFiltering: Bool) {
        interactor?.getBookmarkForNavigation(at: index, isFiltering: isFiltering)
    }
}

// MARK: - BookmarksInteractorOutputProtocol
extension BookmarksPresenter: BookmarksInteractorOutputProtocol {
    func didLoadBookmarks(_ bookmarks: [NewsArticle]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.output?.didLoadBookmarks(bookmarks)
        }
    }

    func didFilterBookmarks(_ filteredBookmarks: [NewsArticle]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.output?.didLoadBookmarks(filteredBookmarks)
        }
    }

    func didGetBookmarkForNavigation(_ bookmark: NewsArticle?) {
        if let bookmark = bookmark {
            router?.navigate(with: bookmark)
        }
    }
}
