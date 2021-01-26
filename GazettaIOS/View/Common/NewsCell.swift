//
//  NewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 22.01.2021.
//

import UIKit

fileprivate let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

protocol NewsCell {
    var viewModel: NewsTableViewCellViewModel? { get set }
    
    var newsLabel: UILabel! { get set }
    var newsImage: UIImageView! { get set }
    var newsPublisherAndDateLabel: UILabel! { get set }
    
    var bookmarkButton: UIButton! { get set }
}

extension NewsCell {
    func update(with news: NewsArticle) {
        if let title = news.title {
            newsLabel.text = title
        }
        if let publisher = news.publisher, let when = news.when {
            newsPublisherAndDateLabel.text = publisher + " • " + dateFormatter.string(from: when)
        }
        if let imageUrl = news.imageUrl {
            UIImage.load(from: imageUrl) { image in
                newsImage.image = image
                newsImage.layer.cornerRadius = 4
            }
        }
        
        if let isBookmark = viewModel?.isArticleBookmarked {
            if isBookmark {
                let image = UIImage(systemName: "bookmark.fill")?.withRenderingMode(.alwaysOriginal)
                bookmarkButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysOriginal)
                bookmarkButton.setImage(image, for: .normal)
            }
        }
    }
}
