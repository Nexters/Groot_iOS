//
//  HomeCardCollectionViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 01/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import SwiftyGif
import Lottie

class HomeCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var plantView: UIImageView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    @IBOutlet weak var wateringAnimation: AnimationView!
    
    weak var delegate: HomeEventDelegate?
    var plant: Plant?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        do {
            let gif = try UIImage(gifName: "plant.gif", levelOfIntegrity: 0.5)
            plantView.setGifImage(gif)
            plantView.startAnimatingGif()
        } catch {
            print(error)
        }
        
        wateringAnimation.center = center
        wateringAnimation.contentMode = .scaleAspectFill
        wateringAnimation.isUserInteractionEnabled = false
        wateringAnimation.isHidden = true
    }

    @IBAction func tapAddWaterButton(_ sender: Any) {
        guard let plant = plant else {
            return 
        }
        
        delegate?.homeEvent(plant, event: .waterToPlant)
    }
    
    func waterToPlant() {
        wateringAnimation.isHidden = false
        wateringAnimation.play(completion: { _ in
            self.wateringAnimation.isHidden = true
        })
    }
    
    func setUp(with plant: Plant) {
        self.plant = plant
        wateringAnimation.isHidden = true
    }
    
}
