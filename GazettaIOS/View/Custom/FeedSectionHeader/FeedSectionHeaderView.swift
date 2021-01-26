//
//  FeedSectionHeaderView.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

class FeedSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var sectionButton: UIButton!
}

extension FeedSectionHeaderView: ViewCellIdentifiable {
    static var identifier: String {
        return "feedSectionHeader"
    }
    
    static var nib: UINib {
        return UINib(nibName: "FeedSectionHeaderView", bundle: nil)
    }
    
}
