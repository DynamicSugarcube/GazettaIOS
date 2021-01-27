//
//  LatestNewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

class LatestNewsTableViewCell: DailyNewsTableViewCell {}

// MARK: - ViewCellIdentifiable
extension LatestNewsTableViewCell: ViewCellIdentifiable {
    static var identifier: String {
        return "latestNewsCell"
    }

    static var nib: UINib {
        return UINib(nibName: "LatestNewsTableViewCell", bundle: nil)
    }
}
