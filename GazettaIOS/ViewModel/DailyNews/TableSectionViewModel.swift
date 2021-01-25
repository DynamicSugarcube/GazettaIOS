//
//  TableSectionProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

enum TableSectionIdentifier: Int {
    case topStories = 0, latestNews, total
}

protocol TableSectionViewModel: BookmarksDelegate {
    var networkDataRetriever: NetworkDataRetriever { get set }
    var databaseInteractor: DatabaseInteractor { get set }
    
    var sectionIdentifier: Int { get }
    var sectionName: String { get }
    var sectionButtonName: String { get }
    
    var dataSet: [NewsArticle] { get set }
    
    func getData(onComplete: @escaping () -> Void)
    func createViewModelForCell(indexOfArticle index: Int) -> NewsTableViewCellViewModel?
}

extension TableSectionViewModel {
    var rowCount: Int {
        return dataSet.count
    }
    
    func createViewModelForCell(indexOfArticle index: Int) -> NewsTableViewCellViewModel? {
        if index >= dataSet.count || index < 0 {
            print("Couldn't create a view model for index: \(index)")
            return nil
        }
        let article = dataSet[index]
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
