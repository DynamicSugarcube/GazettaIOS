//
//  TopStoriesViewModel.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

fileprivate let TOP_STORY_STUB = SingleNews(label: "What happened today? Who knows?", content: "Some long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long description", publisher: "BBC", when: "01.01.2020")

struct TopStoriesViewModel: TableSectionViewModel {
    var sectionIdentifier: Int {
        return TableSectionIdentifier.topStories.rawValue
    }
    
    var sectionName: String {
        return "Top Stories"
    }
    
    var sectionButtonName: String {
        return "More"
    }
    
    var dataSet: [SingleNews] = [TOP_STORY_STUB]
    
    var currentTopStory: SingleNews {
        return dataSet[0]
    }
}
