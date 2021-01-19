//
//  LatestNewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsPublisherAndDateLabel: UILabel!
    @IBOutlet weak var newsPublisherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension LatestNewsTableViewCell: TableCellProtocol {
    static var identifier: String {
        return "latestNewsCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "LatestNewsTableViewCell", bundle: nil)
    }
    
}
