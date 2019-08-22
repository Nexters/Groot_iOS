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
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var plantView: AnimatedImageView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    @IBOutlet weak var wateringAnimation: AnimationView!
    
    weak var delegate: PlantEventDelegate?
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
        layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)

    }

    @IBAction func tapAddWaterButton(_ sender: Any) {
        guard let plant = plant else {
            return 
        }
        delegate?.plantEvent(plant, event: .waterToPlant)
    }
    
    func waterToPlant() {
        wateringAnimation.isHidden = false
        if !wateringAnimation.isAnimationPlaying {
            wateringAnimation.play()
        }
    }
    
    func setUp(with plant: Plant) {
        self.plant = plant
        wateringAnimation.isHidden = true
        nicknameLabel.text = plant.nickName + "에게 물주기"
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
