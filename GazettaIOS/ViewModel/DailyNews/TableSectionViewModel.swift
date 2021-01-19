//
//  TableSectionProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

enum TableSectionIdentifier: Int {
    case topStories = 0, latestNews, total
}

protocol TableSectionViewModel {
    var sectionIdentifier: Int { get }
    var sectionName: String { get }
    var sectionButtonName: String { get }
    
    var dataSet: [SingleNews] { get set }
}

extension TableSectionViewModel {
    var sectionName: String {
        return ""
    }
    
    var sectionButtonName: String {
        return ""
    }
    
    var rowCount: Int {
        return dataSet.count
    }
}
