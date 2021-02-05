//
//  BookmarksPresenterInputProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 04.02.2021.
//

import Foundation

protocol BookmarksPresenterInputProtocol: class {
    func loadBookmarks(searchText: String?)
    func onClickCell(at index: Int, isFiltering: Bool)
}
