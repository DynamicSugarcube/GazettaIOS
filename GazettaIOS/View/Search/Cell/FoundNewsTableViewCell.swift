//
//  FoundNewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 28.01.2021.
//

import UIKit

class FoundNewsTableViewCell: UITableViewCell {
    var data: NewsArticle? {
        didSet {
            guard let data = data else {
                return
            }
            update(with: data)
        }
    }

    private func update(with article: NewsArticle) {
        guard
            let title = article.title,
            let publisher = article.publisher
        else {
            print("Couldn't update cell with article: \(article)")
            return
        }

        newsTitle.text = title
        newsPublisher.text = publisher
    }

    @IBOutlet private(set) weak var newsTitle: UILabel!
    @IBOutlet private(set) weak var newsPublisher: UILabel!
}

// MARK: - ViewCellIdentifiable
extension FoundNewsTableViewCell: ViewCellIdentifiable {
    static var identifier: String {
        "foundNewsCell"
    }

    static var nib: UINib {
        UINib(nibName: "FoundNewsTableViewCell", bundle: nil)
    }
}
