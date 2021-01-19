//
//  TopStoryTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

class TopStoryTableViewCell: UITableViewCell {
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

extension TopStoryTableViewCell: TableCellProtocol {
    static var identifier: String {
        return "topStoryCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "TopStoryTableViewCell", bundle: nil)
    }
    
}
