//
//  TopStoryTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

class TopStoryTableViewCell: DailyNewsTableViewCell {}

// MARK: - ViewCellIdentifiable
extension TopStoryTableViewCell: ViewCellIdentifiable {
    static var identifier: String {
        return "topStoryCell"
    }

    static var nib: UINib {
        return UINib(nibName: "TopStoryTableViewCell", bundle: nil)
    }
}
