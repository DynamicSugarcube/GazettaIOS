//
//  NewsTableCellViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import Foundation

struct NewsCellViewModel {
    var article: NewsArticle

    weak var delegate: BookmarksDelegate?

    var isArticleBookmarked: Bool {
        return delegate?.isBookmark(article) ?? false
    }

    func saveToBookmarks() -> Bool {
        return delegate?.saveToBookmarks(article) ?? false
    }

    func removeFromBookmarks() -> Bool {
        return delegate?.removeFromBookmarks(article) ?? false
    }
}
