//
//  BookmarksInteractorInput.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 04.02.2021.
//

import Foundation

protocol BookmarksInteractorInputProtocol: class {    
    func loadBookmarks()
    func filterBookmarks(searchText: String)
    func getBookmarkForNavigation(at index: Int, isFiltering: Bool)
}
