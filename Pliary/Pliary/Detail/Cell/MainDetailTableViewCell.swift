//
//  MainDetailTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class MainDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var plantView: UIView!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var nameSplitLabel: UILabel!
    @IBOutlet weak var customNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
