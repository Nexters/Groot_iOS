//
//  HomeCardCollectionViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 01/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

class HomeCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var plantView: AnimatedImageView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    @IBOutlet weak var wateringAnimation: AnimationView!
    
    weak var delegate: HomeEventDelegate?
    var plant: Plant? {
        didSet {
            if oldValue != plant {
                animateImage()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    func animateImage() {
        guard let plant = plant else {
            return
        }
        
        let imageName = plant.getPositiveImageName()
        let appendPath = imageName + ".gif"
        let host = API.gifHost?.appendingPathComponent(appendPath)
        let placeHolder = UIImage(named: imageName)
        
        plantView.kf.setImage(with: host, placeholder: placeHolder, options: nil, progressBlock: nil, completionHandler: { _ in
            
        })
    }
    
    func stopImage() {
        guard let plant = plant else {
            return
        }
        
        let imageName = plant.getPositiveImageName()
        let placeHolder = UIImage(named: imageName)
        plantView.image = placeHolder
    }
    
}
