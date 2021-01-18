//
//  NewsTableViewCell.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 17.01.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
