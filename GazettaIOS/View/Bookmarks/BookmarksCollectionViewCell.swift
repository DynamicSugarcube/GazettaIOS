//
//  BookmarksCollectionViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import UIKit

fileprivate let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

class BookmarksCollectionViewCell: UICollectionViewCell {
    // TODO: Inject it?
    var viewModel: NewsTableViewCellViewModel? = nil {
        didSet {
            if let article = viewModel?.article {
                update(with: article)
            }
        }
    }
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsPublisher: UILabel!
    @IBOutlet weak var newsDate: UILabel!

    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBAction func onBookmarkButtonPressed() {
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
    
    private func update(with article: NewsArticle) {
        guard let title = article.title else { return }
        guard let publisher = article.publisher else { return }
        guard let date = article.when else { return }
        
        newsTitle.text = title
        newsPublisher.text = publisher
        newsDate.text = dateFormatter.string(from: date)
        
        if let imageUrl = article.imageUrl {
            UIImage.load(from: imageUrl) { [weak self] image in
                self?.newsImage.image = image
                self?.newsImage.layer.cornerRadius = 4
            }
        }
        
        if let isBookmark = viewModel?.isArticleBookmarked {
            if isBookmark {
                bookmarkButton.setImage(ViewCellResources.bookmarkFillImage, for: .normal)
            } else {
                bookmarkButton.setImage(ViewCellResources.bookmarkImage, for: .normal)
            }
        }
    }
}

extension BookmarksCollectionViewCell: ViewCellIdentifiable {
    static var identifier: String {
        return "bookmarksCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "BookmarksCollectionViewCell", bundle: nil)
    }
}
