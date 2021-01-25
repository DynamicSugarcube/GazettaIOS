//
//  LatestNewsViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

class LatestNewsViewModel: TableSectionViewModel {
    internal var networkDataRetriever: NetworkDataRetriever
    internal var databaseInteractor: DatabaseInteractor
    
    init(networkDataRetriever: NetworkDataRetriever, databaseInteractor: DatabaseInteractor) {
        self.networkDataRetriever = networkDataRetriever
        self.databaseInteractor = databaseInteractor
    }
    
    var sectionIdentifier: Int {
        return TableSectionIdentifier.latestNews.rawValue
    }
    
    var sectionName: String {
        return "Latest News"
    }
    
    var sectionButtonName: String {
        return "See All"
    }
    
    var dataSet: [NewsArticle] = []
    
    func getData(onComplete: @escaping () -> Void) {
        // MARK: TODO Change request to LatestNewsRequest when it's ready
        let request = TopStoriesRequest(country: .us)
        networkDataRetriever.getNewsArticles(on: request) { [weak self] articles in
            self?.dataSet = articles
            onComplete()
        }
    }
}