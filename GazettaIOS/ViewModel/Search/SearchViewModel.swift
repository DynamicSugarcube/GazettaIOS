//
//  SearchViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 28.01.2021.
//

import Foundation

class SearchViewModel {
    let searchPlaceholder = "Search for news"

    let showNewsDetailsSegueId = "showNewsDetails"

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getArticles(for searchText: String, onComplete: @escaping () -> Void) {
        let request = LatestNewsRequest(keyword: searchText.lowercased())
        networkService.getNewsArticles(on: request) { [weak self] articles in
            guard let self = self else {
                return
            }
            self.foundArticles = articles
            onComplete()
        }
    }

    func getDataForCell(at index: Int) -> NewsArticle? {
        if !foundArticles.indices.contains(index) {
            print("Couldn't find article for index \(index)")
            return nil
        }
        return foundArticles[index]
    }

    private let networkService: NetworkService

    private(set) var foundArticles: [NewsArticle] = []
}
