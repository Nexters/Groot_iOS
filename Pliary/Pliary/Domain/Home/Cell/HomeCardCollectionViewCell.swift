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
    var currentStatus: PlantStatus = .negative
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
        layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)
    }

    @IBAction func tapAddWaterButton(_ sender: Any) {
        guard let plant = plant else {
            return 
        }
        delegate?.plantEvent(plant, event: .waterToPlant)
    }
    
    func waterToPlant() {
        currentStatus = .positive
        wateringAnimation.stop()
        wateringAnimation.play(completion: { _ in
            self.animateImage()
        })
    }
    
    func daysBetween(start: Date, end: Date) -> Int? {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)
    }
    
    func setUp(with plant: Plant) {
        self.plant = plant
        nicknameLabel.text = plant.nickName + "에게 물주기"
        
        // negative or postive 계산 (d-day)
        let lastWaterDay = Date(timeIntervalSince1970: plant.lastWaterDate)
        let interval = plant.wateringInterval
        if let waterDiffer = daysBetween(start: lastWaterDay, end: Date()) {
            let dDay = (interval - waterDiffer)
            if dDay == 0 {
                dayLeftLabel.text = "D-day"
                currentStatus = .negative
            } else if dDay < 0 {
                dayLeftLabel.text = "D+" + abs(dDay).description
                currentStatus = .negative
            } else {
                dayLeftLabel.text = "D-" + dDay.description
                currentStatus = .positive
            }
        }
        
    }
    
    func animateImage() {
        guard let plant = plant else {
            return
        }
        
        var imageName: String {
            switch currentStatus {
            case .positive:
                return plant.getPositiveImageName()
            case .negative:
                return plant.getNegativeImageName()
            }
        }
        
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
        
        var imageName: String {
            switch currentStatus {
            case .positive:
                return plant.getPositiveImageName()
            case .negative:
                return plant.getNegativeImageName()
            }
        }
        
        let placeHolder = UIImage(named: imageName)
        plantView.image = placeHolder
    }
    
}
