//
//  RegisterPlantDateTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class RegisterPlantDateTableViewCell: UITableViewCell, RegisterCell {
    
    var type: RegisterRowType?
    var plant: Plant?
    weak var delegate: RegisterEventDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    
    @IBAction func tapDateButton(_ sender: Any) {
        guard let type = type else {
            return
        }
        
        delegate?.registerEvent(event: .selectDate(type: type))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(with plant: Plant, type: RegisterRowType) {
        self.plant = plant
        self.type = type
        
        handleType(type)
    }
    
    func handleType(_ type: RegisterRowType) {
        switch type {
        case .startDate:
            titleLabel.text = "식물 입양한 날"
        case .lastWaterDate:
            titleLabel.text = "마지막으로 물준 날"
        default:
            ()
        }
    }
}
