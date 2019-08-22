//
//  SettingSwitchTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 10/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class SettingSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
