//
//  TableSectionProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

enum TableSectionIdentifier: Int {
    case topStories = 0, latestNews, total
}

protocol TableSectionViewModel: class {
    var sectionIdentifier: Int { get }
    var sectionName: String { get }
    var sectionButtonName: String { get }
    
    var dataSet: [NewsArticle] { get set }
    
    func getData(onComplete: @escaping () -> Void)
}

extension TableSectionViewModel {
    var rowCount: Int {
        return dataSet.count
    }
}
