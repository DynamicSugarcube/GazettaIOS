//
//  NewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 22.01.2021.
//

import UIKit

protocol NewsTableViewCell {
    var newsLabel: UILabel! { get set }
    var newsImage: UIImageView! { get set }
    var newsPublisherAndDateLabel: UILabel! { get set }
    var newsPublisherImage: UIImageView! { get set }
}

extension NewsTableViewCell {
    func update(with news: NewsArticle) {
        if let title = news.title {
            newsLabel.text = title
        }
        if let publisher = news.publisher, let when = news.when {
            newsPublisherAndDateLabel.text = publisher + " • " + when
        }
        if let imageUrl = news.imageUrl {
            UIImage.load(from: imageUrl) { image in
                newsImage.image = image
                newsImage.layer.cornerRadius = 4
            }
        }
    }
}
