//
//  LatestNewsViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

fileprivate let NEWS_ARRAY_STUB = Array.init(repeating: SingleNews(label: "Breaking news", content: "Something happened", publisher: "CNN", when: "03.01.2021"), count: 20)

struct LatestNewsViewModel: TableSectionViewModel {
    var sectionIdentifier: Int {
        return TableSectionIdentifier.latestNews.rawValue
    }
    
    var sectionName: String {
        return "Latest News"
    }
    
    var sectionButtonName: String {
        return "See All"
    }
    
    var dataSet: [SingleNews] = NEWS_ARRAY_STUB
}
