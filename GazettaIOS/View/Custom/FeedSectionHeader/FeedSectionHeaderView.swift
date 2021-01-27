//
//  FeedSectionHeaderView.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

class FeedSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private(set) weak var sectionLabel: UILabel!
    @IBOutlet private(set) weak var sectionButton: UIButton!
}

// MARK: - ViewCellIdentifiable
extension FeedSectionHeaderView: ViewCellIdentifiable {
    static var identifier: String {
        return "feedSectionHeader"
    }

    static var nib: UINib {
        return UINib(nibName: "FeedSectionHeaderView", bundle: nil)
    }
}
