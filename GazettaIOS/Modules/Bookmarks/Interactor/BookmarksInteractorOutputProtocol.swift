//
//  BookmarksInteractorOutput.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 04.02.2021.
//

import Foundation

protocol BookmarksInteractorOutputProtocol: class {
    func didLoadBookmarks(_ bookmarks: [NewsArticle])
    func didFilterBookmarks(_ filteredBookmarks: [NewsArticle])
    func didGetBookmarkForNavigation(_ bookmark: NewsArticle?)
}
