//
//  DailyNewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 27.01.2021.
//

import UIKit

class DailyNewsTableViewCell: UITableViewCell, Shareable {
    var viewModel: NewsCellViewModel? {
        didSet {
            if let article = viewModel?.article {
                update(with: article)
            }
        }
    }

    weak var presenter: UIViewController?

    @IBAction private func onBookmarksPressed() {
        guard let viewModel = self.viewModel else { return }
        if viewModel.isArticleBookmarked {
            if viewModel.removeFromBookmarks() {
                bookmarkButton.setImage(ViewCellResources.bookmarkImage, for: .normal)
            }
        } else {
            if viewModel.saveToBookmarks() {
                bookmarkButton.setImage(ViewCellResources.bookmarkFillImage, for: .normal)
            }
        }
    }

    @IBAction private func onSendPressed() {
        guard
            let article = viewModel?.article,
            let presenter = presenter
        else {
            return
        }
        share(article: article, presenter: presenter)
    }

    private func update(with article: NewsArticle) {
        guard
            let title = article.title,
            let publisher = article.publisher,
            let date = article.when
        else {
            print("Couldn't update cell with data: \(article)")
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short

        newsLabel.text = title
        newsPublisherAndDateLabel.text = "\(publisher) • \(date)"

        if let url = article.imageUrl {
            UIImage.load(from: url) { [weak self] image in
                guard let self = self else { return }
                self.newsImage.image = image
                self.newsImage.layer.cornerRadius = 4
            }
        }

        if viewModel?.isArticleBookmarked == true {
            bookmarkButton.setImage(ViewCellResources.bookmarkFillImage, for: .normal)
        } else {
            bookmarkButton.setImage(ViewCellResources.bookmarkImage, for: .normal)
        }
    }

    @IBOutlet private weak var newsLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsPublisherAndDateLabel: UILabel!
    @IBOutlet private weak var bookmarkButton: UIButton!
}
