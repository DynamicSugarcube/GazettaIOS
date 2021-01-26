//
//  DailyNewsViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import Foundation

class DailyNewsViewModel: BookmarksDelegate {
    private var networkDataRetriever: NetworkDataRetriever
    private var databaseInteractor: DatabaseInteractor
    
    init(networkDataRetriever: NetworkDataRetriever, databaseInteractor: DatabaseInteractor) {
        self.networkDataRetriever = networkDataRetriever
        self.databaseInteractor = databaseInteractor
    }
    
    private(set)var sections: [TableSectionProtocol] = [TopStoriesSection(), LatestNewsSection()]
    
    func getTopStoriesOverNetwork(onComplete: @escaping () -> Void) {
        let request = TopStoriesRequest(country: .us)
        networkDataRetriever.getNewsArticles(on: request) { [weak self] articles in
            self?.sections[0].dataSet = articles
            onComplete()
        }
    }
    
    func getLatestNewsOverNetwork(onComplete: @escaping () -> Void) {
        // TODO: Change request
        let request = TopStoriesRequest(country: .us)
        networkDataRetriever.getNewsArticles(on: request) { [weak self] articles in
            self?.sections[1].dataSet = articles
            onComplete()
        }
    }
    
    func createViewModelForTopStoryCell() -> NewsTableViewCellViewModel? {
        guard let section = sections[safe: 0] else {
            print("Couldn't find Top Stories section")
            return nil
        }
        
        if section.dataSet.isEmpty {
            print("No top stories found")
            return nil
        }
        
        let article = section.dataSet[0]
        return NewsTableViewCellViewModel(article: article, delegate: self)
    }
    
    func createViewModelForLatestNewsCell(indexOfArticle index: Int) -> NewsTableViewCellViewModel? {
        guard let section = sections[safe: 1] else {
            print("Couldn't find Latest News section")
            return nil
        }
        
        if index >= section.dataSet.count || index < 0 {
            print("Couldn't find article. Index is out of range")
            return nil
        }
        
        let article = section.dataSet[index]
        return NewsTableViewCellViewModel(article: article, delegate: self)
    }
    
    func isBookmark(_ article: NewsArticle) -> Bool {
        return databaseInteractor.isInDatabase(article)
    }
    
    func saveToBookmarks(_ article: NewsArticle) -> Bool {
        return databaseInteractor.saveToDatabase(article)
    }
    
    func removeFromBookmarks(_ article: NewsArticle) -> Bool {
        return databaseInteractor.removeFromDatabase(article)
    }
}
