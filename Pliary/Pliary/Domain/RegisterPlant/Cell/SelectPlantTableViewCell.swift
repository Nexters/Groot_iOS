//
//  SelectPlantTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class SelectPlantTableViewCell: UITableViewCell {

    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var plant: Plant?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        selectedImageView.isHidden = true
    }
    
    func selected() {
        backgroundColor = Color.gray7
        selectedImageView.isHidden = false
    }
    
    func deselected() {
        backgroundColor = .white
        selectedImageView.isHidden = true
    }
    
    func setUp(with plant: Plant, selected: Bool = false) {
        self.plant = plant
        
        switch plant.type {
        case .userPlants:
            englishNameLabel.text = "직접 입력"
            englishNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
            koreanNameLabel.isHidden = true
        case .hangingPlant:
            englishNameLabel.text = "행잉플랜트 등록"
            englishNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
            koreanNameLabel.isHidden = true
        default:
            englishNameLabel.text = plant.englishName
            englishNameLabel.font = UIFont(name: "Baskerville-Bold", size: 18)
            koreanNameLabel.text = plant.koreanName
            koreanNameLabel.isHidden = false
        }
        
        if selected {
            self.selected()
        } else {
            self.deselected()
        }
    }
}
