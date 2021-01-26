//
//  DependencyProvider.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 24.01.2021.
//

import Swinject
import CoreData
import UIKit

class DependencyProvider {
    private static var sharedContainer: Container = {
        let container = Container()
        
        container.register(DailyNewsViewModel.self) { _ in
            DailyNewsViewModel(networkDataRetriever: networkDataRetriever, databaseInteractor: databaseInteractor)
        }.inObjectScope(.container)
        container.register(BookmarksViewModel.self) { _ in
            BookmarksViewModel(databaseInteractor: databaseInteractor)
        }.inObjectScope(.container)
        
        return container
    }()
    
    static func getDailyNewsViewModel() -> DailyNewsViewModel! {
        return sharedContainer.resolve(DailyNewsViewModel.self)
    }
    
    static func getBookmarksViewModel() -> BookmarksViewModel! {
        return sharedContainer.resolve(BookmarksViewModel.self)
    }
    
    private static var networkDataRetriever = NetworkDataRetrieverImpl()
    private static var databaseInteractor = DatabaseInteractorImpl(context: managedContext)
    
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private static let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    private static let storeCoordinator: NSPersistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
}
