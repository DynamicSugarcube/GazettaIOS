//
//  BookmarksViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import Foundation

struct BookmarksViewModel {
    let searchPlaceholder = "Search for bookmarks"

    func createViewModel(forCellAt index: Int, delegate: BookmarksDelegate) -> NewsCellViewModel? {
        bookmarks.indices.contains(index) ? NewsCellViewModel(article: bookmarks[index], delegate: delegate) : nil
    }

    var bookmarks: [NewsArticle] = []
}
