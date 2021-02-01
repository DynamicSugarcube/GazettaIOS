//
//  DailyNewsViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import Foundation

class DailyNewsViewModel {
    let topStoriesSectionId = TableSection.topStories.rawValue
    let latestNewsSectionId = TableSection.latestNews.rawValue

    var numberOfSections: Int {
        TableSection.total.rawValue
    }

    let showNewsDetailsSegueId = "showNewsDetails"
    let showSearchSegueId = "showSearch"

    let headerSectionHeight = 50

    init(networkService: NetworkService, databaseService: DatabaseService) {
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func calculateNumberOfRows(for section: Int) -> Int {
        switch section {
        case TableSection.topStories.rawValue:
            return 1
        case TableSection.latestNews.rawValue:
            return latestNews.count
        default:
            print("Couldn't calculate number of rows for section with ID \(section)")
            return 0
        }
    }

    func getAttributes(for section: Int) -> (sectionLabel: String, buttonLabel: String)? {
        guard let tableSection = TableSection(rawValue: section) else {
            print("Couldn't get attributes for section with ID \(section)")
            return nil
        }
        return (tableSection.sectionName, tableSection.sectionButtonLabel)
    }

    func refreshDailyNews(
        onTopStroiesLoaded: @escaping () -> Void,
        onLatestNewsLoaded: @escaping () -> Void,
        onRefreshDone: @escaping () -> Void = {}
    ) {
        let refreshGroup = DispatchGroup()
        let refreshQueue = DispatchQueue.global(qos: .utility)
        refreshQueue.async(group: refreshGroup) { [weak self] in
            guard let self = self else { return }
            self.getTopStoriesOverNetwork {
                DispatchQueue.main.async {
                    onTopStroiesLoaded()
                }
            }
        }
        refreshQueue.async(group: refreshGroup) { [weak self] in
            guard let self = self else { return }
            self.getLatestNewsOverNetwork {
                DispatchQueue.main.async {
                    onLatestNewsLoaded()
                }
            }
        }
        refreshGroup.notify(queue: DispatchQueue.main) {
            onRefreshDone()
        }
    }

    func createViewModelForTopStoryCell() -> NewsCellViewModel? {
        if topStories.isEmpty {
            print("Couldn't find article. No top stories found")
            return nil
        }
        let article = topStories[0]
        return NewsCellViewModel(article: article, delegate: self)
    }

    func createViewModelForLatestNewsCell(indexOfArticle index: Int) -> NewsCellViewModel? {
        if !latestNews.indices.contains(index) {
            print("Couldn't find article. Index is out of range")
            return nil
        }
        let article = latestNews[index]
        return NewsCellViewModel(article: article, delegate: self)
    }

    private func getTopStoriesOverNetwork(onComplete: @escaping () -> Void) {
        let request = TopStoriesRequest(country: .usa)
        networkService.getNewsArticles(on: request) { [weak self] articles in
            guard let self = self else { return }
            self.topStories = articles
            onComplete()
        }
    }

    private func getLatestNewsOverNetwork(onComplete: @escaping () -> Void) {
        // TODO: Change request
        let request = TopStoriesRequest(country: .usa)
        networkService.getNewsArticles(on: request) { [weak self] articles in
            guard let self = self else { return }
            self.latestNews = articles
            onComplete()
        }
    }

    private var networkService: NetworkService
    private var databaseService: DatabaseService

    private(set) var topStories: [NewsArticle] = []
    private(set) var latestNews: [NewsArticle] = []
}

// MARK: - BookmarksDelegate
extension DailyNewsViewModel: BookmarksDelegate {
    func isBookmark(_ article: NewsArticle) -> Bool {
        databaseService.isInDatabase(article)
    }

    func saveToBookmarks(_ article: NewsArticle) -> Bool {
        databaseService.saveToDatabase(article)
    }

    func removeFromBookmarks(_ article: NewsArticle) -> Bool {
        databaseService.removeFromDatabase(article)
    }
}
