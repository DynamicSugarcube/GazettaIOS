//
//  LatestNewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell, NewsTableViewCell {
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsPublisherAndDateLabel: UILabel!
    @IBOutlet weak var newsPublisherImage: UIImageView!
}

extension LatestNewsTableViewCell: TableCellProtocol {
    static var identifier: String {
        return "latestNewsCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "LatestNewsTableViewCell", bundle: nil)
    }
}
