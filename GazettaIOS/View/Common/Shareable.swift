//
//  Shareable.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 01.02.2021.
//

import UIKit

protocol Shareable {
    func share(article: NewsArticle, presenter: UIViewController)
}

extension Shareable {
    func share(article: NewsArticle, presenter: UIViewController) {
        guard
            let description = article.title,
            let url = article.newsUrl,
            let link = URL(string: url)
        else {
            print("Couldn't share news article")
            return
        }

        let items: [Any] = [description, link]

        let activityViewController = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil)
        activityViewController.activityItemsConfiguration =
            [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        activityViewController.isModalInPresentation = true

        presenter.present(activityViewController, animated: true, completion: nil)
    }
}
