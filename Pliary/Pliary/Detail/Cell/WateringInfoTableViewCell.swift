//
//  DrinkingInfoCardTableViewCell.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 6..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class WateringInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var waterImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}