//
//  BookmarksCollectionViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import UIKit

class BookmarksCollectionViewCell: UICollectionViewCell, Shareable {
    var viewModel: NewsCellViewModel? {
        didSet {
            if let article = viewModel?.article {
                update(with: article)
            }
        }
    }

    weak var presenter: UIViewController?

    @IBAction private func onSendPressed() {
        guard
            let article = viewModel?.article,
            let presenter = presenter
        else {
            return
        }

        let animation = AnimationProvider.buildRotationAnimation(for: sendButton)
        UIView.animate(
            withDuration: AnimationProvider.animationDuration,
            animations: animation,
            completion: nil)

        share(article: article, presenter: presenter)
    }

    @IBAction private func onBookmarkButtonPressed() {
        guard let viewModel = self.viewModel else { return }

        let animation = AnimationProvider.buildRotationAnimation(for: bookmarkButton)
        UIView.animate(
            withDuration: AnimationProvider.animationDuration,
            animations: animation,
            completion: nil)

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
        dateFormatter.dateStyle = .medium

        newsTitle.text = title
        newsPublisher.text = publisher
        newsDate.text = dateFormatter.string(from: date)

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

    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsPublisher: UILabel!
    @IBOutlet private weak var newsDate: UILabel!
    @IBOutlet private weak var bookmarkButton: UIButton!
    @IBOutlet private weak var sendButton: UIButton!
}

// MARK: - ViewCellIdentifiable
extension BookmarksCollectionViewCell: ViewCellIdentifiable {
    static var identifier: String {
        return "bookmarksCell"
    }
    static var nib: UINib {
        return UINib(nibName: "BookmarksCollectionViewCell", bundle: nil)
    }
}
