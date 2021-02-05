//
//  BookmarksPresenterOutputProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 04.02.2021.
//

import Foundation

protocol BooksmarksPresenterOutputProtocol: class {
    func didLoadBookmarks(_ bookmarks: [NewsArticle])
}
