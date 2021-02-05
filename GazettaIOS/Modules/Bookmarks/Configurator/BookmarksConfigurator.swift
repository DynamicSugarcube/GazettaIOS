//
//  BookmarksConfigurator.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 03.02.2021.
//

import Foundation

class BookmarksConfigurator {
    static func configure(with viewController: BookmarksViewController) {
        let presenter = BookmarksPresenter(output: viewController)
        viewController.presenter = presenter

        let databaseService = DependencyProvider.getDatabaseService()
        let interactor = BookmarksInteractor(output: presenter, databaseService: databaseService)
        presenter.interactor = interactor

        let router = BookmarksRouter(
            presenter: presenter,
            navigationController: viewController.navigationController)
        presenter.router = router
    }
}
