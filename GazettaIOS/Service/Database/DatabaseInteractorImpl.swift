//
//  DatabaseInteractorImpl.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 24.01.2021.
//

import CoreData
import Foundation

class DatabaseInteractorImpl: DatabaseInteractor {
    private var managedContext: NSManagedObjectContext
    
    init(context managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func isInDatabase(_ newsArticle: NewsArticle) -> Bool {
        guard let url = newsArticle.newsUrl else { return false }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
        fetchRequest.predicate = NSPredicate(format: "newsUrl = %@", url)
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            if fetchResult.count > 0 {
                return true
            }
        } catch let error {
            print("Couldn't find provided article in database. \(error)")
        }
        
        return false
    }
    
    func saveToDatabase(_ newsArticle: NewsArticle) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedContext)!
        let article = NSManagedObject(entity: entity, insertInto: managedContext)
        
        article.setValue(newsArticle.publisher, forKey: "publisher")
        article.setValue(newsArticle.title, forKey: "title")
        article.setValue(newsArticle.newsUrl, forKey: "newsUrl")
        article.setValue(newsArticle.imageUrl, forKey: "imageUrl")
        article.setValue(newsArticle.when, forKey: "when")
        
        if managedContext.hasChanges {
            do {
                try managedContext.save()
                return true
            } catch let error {
                print("Couldn't save article to database. \(error)")
            }
        }
        
        return false
    }
    
    func removeFromDatabase(_ newsArticle: NewsArticle) -> Bool {
        guard let url = newsArticle.newsUrl else { return false }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
        fetchRequest.predicate = NSPredicate(format: "newsUrl = %@", url)
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            for object in fetchResult {
                managedContext.delete(object)
            }
            if managedContext.hasChanges {
                try managedContext.save()
                return true
            }
        } catch let error {
            print("Couldn't delete article in database. \(error)")
        }
        
        return false
    }
    
    func getFromDatabase(onComplete: @escaping ([NewsArticle]) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            let articles = mapFetchedData(fetchResult)
            onComplete(articles)
        } catch let error {
            print("Couldn't fetch articles from database. \(error)")
        }
    }
    
    private func mapFetchedData(_ fetched: [NSManagedObject]) -> [NewsArticle] {
        return fetched.map { object in
            let publisher = object.value(forKey: "publisher") as? String
            let title = object.value(forKey: "title") as? String
            let newsUrl = object.value(forKey: "newsUrl") as? String
            let imageUrl = object.value(forKey: "imageUrl") as? String
            let when = object.value(forKey: "when") as? Date
            return NewsArticle(publisher: publisher, title: title, newsUrl: newsUrl, imageUrl: imageUrl, when: when)
        }
    }
}
