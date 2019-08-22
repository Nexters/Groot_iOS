//
//  MainDetailTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

class MainDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var plantView: UIImageView!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var nameSplitLabel: UILabel!
    @IBOutlet weak var customNameLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var wateringAnimation: AnimationView!
    
    weak var delegate: DetailEventDelegate?
    var currentStatus: PlantStatus = .negative
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        wateringAnimation.center = center
        wateringAnimation.contentMode = .scaleAspectFill
        wateringAnimation.isUserInteractionEnabled = false
        wateringAnimation.isHidden = true
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        delegate?.detailEvent(event: .dismiss)
    }
    
    @IBAction func tapMoreButton(_ sender: Any) {
        guard let plant = Global.shared.selectedPlant else {
            return
        }
        
        delegate?.detailEvent(plant, event: .modifyOrDeletePlant)
    }
    
    @IBAction func tapAddWaterButton(_ sender: Any) {
        guard let plant = Global.shared.selectedPlant else {
            return
        }
        
        delegate?.detailEvent(plant, event: .waterToPlant)
    }
    
    @IBAction func tapNextPageButton(_ sender: Any) {
        delegate?.detailEvent(event: .scrollToNextPage)
    }
    
    func setUp() {
        englishNameLabel.text = Global.shared.selectedPlant?.englishName
        koreanNameLabel.text = Global.shared.selectedPlant?.koreanName
        customNameLabel.text = Global.shared.selectedPlant?.nickName
        tipLabel.text = Global.shared.selectedPlant?.getTip()
        
        wateringAnimation.isHidden = true
        
        // negative or postive 계산 (d-day)
    }
    
    func animateImage() {
        guard let plant = Global.shared.selectedPlant else {
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
        guard let plant = Global.shared.selectedPlant else {
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
    
    func waterToPlant() {
        wateringAnimation.isHidden = false
        if !wateringAnimation.isAnimationPlaying {
            wateringAnimation.play(completion: { _ in
                self.currentStatus = .positive
                self.animateImage()
            })
        }
    }
    
    func makeDeleteMode() {
        guard let plant = Global.shared.selectedPlant else {
            return
        }
        
        let imageName = plant.getPositiveImageName()
        let placeHolder = UIImage(named: imageName)?.convertToGrayScale()
        plantView.image = placeHolder
        
        let blackImage = UIImage(named: ImageName.addWaterGrayButton)
        addWaterButton.setImage(blackImage, for: .normal)
    }
    
    func clearDeleteMode() {
        animateImage()
        
        let image = UIImage(named: ImageName.addWaterButton)
        addWaterButton.setImage(image, for: .normal)
    }
}
