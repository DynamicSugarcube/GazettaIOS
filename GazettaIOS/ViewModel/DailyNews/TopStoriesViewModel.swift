//
//  TopStoriesViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

class TopStoriesViewModel: TableSectionViewModel {
    // MARK: TODO Inject it
    private let dataRetriever = NetworkDataRetrieverImpl()
    
    var sectionIdentifier: Int {
        return TableSectionIdentifier.topStories.rawValue
    }
    
    var sectionName: String {
        return "Top Stories"
    }
    
    var sectionButtonName: String {
        return "More"
    }
    
    var dataSet: [NewsArticle] = []
    
    var currentTopStory: NewsArticle? {
        if dataSet.isEmpty {
            return nil
        } else {
            return dataSet[0]
        }
    }
    
    var rowCount: Int {
        return 1
    }
    
    func getData(onComplete: @escaping () -> Void) {
        let request = TopStoriesRequest(country: .us)
        dataRetriever.getNewsArticles(on: request) { [weak self] articles in
            self?.dataSet = articles
            onComplete()
        }
    }
}
