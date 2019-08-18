//
//  RegisterPlantDateTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class RegisterPlantDateTableViewCell: UITableViewCell {

    @IBOutlet weak var dateButton: UIButton!
    weak var delegate: RegisterEventDelegate?
    
    @IBAction func tapDateButton(_ sender: Any) {
        delegate?.registerEvent(event: .selectDate)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
