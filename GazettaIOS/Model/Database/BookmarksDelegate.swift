//
//  BookmarksDelegate.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 25.01.2021.
//

import Foundation

protocol BookmarksDelegate: AnyObject {
    func isBookmark(_ article: NewsArticle) -> Bool
    func saveToBookmarks(_ article: NewsArticle) -> Bool
    func removeFromBookmarks(_ article: NewsArticle) -> Bool
}

extension BookmarksDelegate {
    func isBookmark(_ article: NewsArticle) -> Bool {
        // Do nothing
        return false
    }
    
    func saveToBookmarks(_ article: NewsArticle) -> Bool {
        // Do nothing
        return false
    }
    
    func removeFromBookmarks(_ article: NewsArticle) -> Bool {
        // Do nothing
        return false
    }
}
