//
//  TableSection.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import Foundation

protocol TableSectionProtocol {
    var name: String { get set }
    var buttonLabel: String { get set }
    
    var dataSet: [NewsArticle] { get set }
    var numberOfRows: Int { get }
}

extension TableSectionProtocol {
    var numberOfRows: Int {
        return dataSet.count
    }
}

struct TopStoriesSection: TableSectionProtocol {
    var name = "Top Stories"
    var buttonLabel = "More"
    
    var dataSet: [NewsArticle] = []
    
    var numberOfRows: Int {
        return 1
    }
}

struct LatestNewsSection: TableSectionProtocol {
    var name = "Latest News"
    var buttonLabel = "See All"
    
    var dataSet: [NewsArticle] = []
}
