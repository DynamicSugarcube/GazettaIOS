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
            DailyNewsViewModel(networkService: networkService, databaseService: databaseService)
        }.inObjectScope(.container)
        container.register(SearchViewModel.self) { _ in
            SearchViewModel(networkService: networkService)
        }.inObjectScope(.container)

        return container
    }()

    static func getDailyNewsViewModel() -> DailyNewsViewModel! {
        return sharedContainer.resolve(DailyNewsViewModel.self)
    }

    static func getSearchViewModel() -> SearchViewModel! {
        return sharedContainer.resolve(SearchViewModel.self)
    }

    // TODO: Remove
    static func getDatabaseService() -> DatabaseService {
        databaseService
    }

    private static var networkService = NetworkServiceImpl()
    private static var databaseService = DatabaseServiceImpl(context: managedContext)

    private static let managedContext = DatabaseStack.persistentContainer.viewContext
    private static let storeCoordinator = DatabaseStack.persistentContainer.persistentStoreCoordinator
}
