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
    @IBOutlet weak var referenceTextLabel: UILabel!
    
    func setUp(with plant: Plant, type: RegisterRowType) {
        self.plant = plant
        self.type = type
        
        let imageName = plant.getPositiveImageName()
        plantImageView.image = UIImage(named: imageName)
        
        switch plant.type {
        case .stuki:
            referenceTextLabel.text = PlantReference.stuki.rawValue
        case .eucalyptus:
            referenceTextLabel.text = PlantReference.eucalyptus.rawValue
        case .sansevieria:
            referenceTextLabel.text = PlantReference.sansevieria.rawValue
        case .monstera:
            referenceTextLabel.text = PlantReference.monstera.rawValue
        case .parlourPalm:
            referenceTextLabel.text = PlantReference.parlourPalm.rawValue
        case .elastica:
            referenceTextLabel.text = PlantReference.elastica.rawValue
        case .travelersPalm:
            referenceTextLabel.text = PlantReference.travelersPalm.rawValue
        case .schefflera:
            referenceTextLabel.text = PlantReference.schefflera.rawValue
        case .userPlants:
            referenceTextLabel.text = PlantReference.userPlants.rawValue
        }
    }
}
