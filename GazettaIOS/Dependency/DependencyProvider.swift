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
        container.register(BookmarksViewModel.self) { _ in
            BookmarksViewModel(databaseService: databaseService)
        }.inObjectScope(.container)

        return container
    }()

    static func getDailyNewsViewModel() -> DailyNewsViewModel! {
        return sharedContainer.resolve(DailyNewsViewModel.self)
    }

    static func getBookmarksViewModel() -> BookmarksViewModel! {
        return sharedContainer.resolve(BookmarksViewModel.self)
    }

    private static var networkService = NetworkServiceImpl()
    private static var databaseService = DatabaseServiceImpl(context: managedContext)

    private static let managedContext = DatabaseStack.persistentContainer.viewContext
    private static let storeCoordinator = DatabaseStack.persistentContainer.persistentStoreCoordinator
}
