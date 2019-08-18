//
//  RegisterPlantImageTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class RegisterPlantImageTableViewCell: UITableViewCell, RegisterCell {
    
    var type: RegisterRowType?
    var plant: Plant?

    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var helpTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(with plant: Plant, type: RegisterRowType) {
        self.plant = plant
        self.type = type
        
        plantImageView.image = UIImage(named: plant.imageName)
    }
}
