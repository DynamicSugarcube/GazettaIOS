//
//  LatestNewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell, NewsCell {
    // MARK: TODO Inject it?
    var viewModel: NewsTableViewCellViewModel? = nil {
        didSet {
            if let article = viewModel?.article {
                update(with: article)
            }
        }
    }
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsPublisherAndDateLabel: UILabel!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBAction func onBookmarksPressed() {
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
}

extension LatestNewsTableViewCell: ViewCellIdentifiable {
    static var identifier: String {
        return "latestNewsCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "LatestNewsTableViewCell", bundle: nil)
    }
}
