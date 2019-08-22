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
        layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)
    }
    
    func setUp() {
        let day: Int = 1000
        dayWithLabel.text = day.description + "일"
        dayWithPlantLabel.text = (Global.shared.selectedPlant?.nickName ?? "") + "와(과) " + day.description + "일을 함게 했어요!"
    }
    
}
