//
//  DayWithPlantTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 08/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class DayWithPlantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayWithPlantLabel: UILabel!
    @IBOutlet weak var dayWithLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        let day: Int = 1000
        dayWithLabel.text = day.description + "일"
        dayWithPlantLabel.text = (Global.shared.selectedPlant?.nickName ?? "") + "와(과) " + day.description + "일을 함게 했어요!"
        
    }
    
}
