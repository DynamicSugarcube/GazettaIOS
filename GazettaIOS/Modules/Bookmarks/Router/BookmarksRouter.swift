//
//  BookmarksRouterImpl.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 03.02.2021.
//

import UIKit

class BookmarksRouter: BookmarksRouterProtocol {
    weak var presenter: BookmarksPresenter?
    weak var navigationController: UINavigationController?

    init(presenter: BookmarksPresenter, navigationController: UINavigationController?) {
        self.presenter = presenter
        self.navigationController = navigationController
        if self.navigationController == nil {
            print("Couldn't find navigation controller. Navigation is unavailable")
        }
    }

    func navigate(with data: NewsArticle) {
        guard
            let navigationController = navigationController,
            let viewController = UIStoryboard(name: newsDetailsStoryboardName, bundle: nil)
                .instantiateViewController(withIdentifier: newsDetailsStoryboardId)
                as? NewsDetailsViewController
        else {
            return
        }

        viewController.data = data
        navigationController.pushViewController(viewController, animated: true)
    }

    private let newsDetailsStoryboardName = "NewsDetails"
    private let newsDetailsStoryboardId = "NewsDetailsStoryboard"
}
