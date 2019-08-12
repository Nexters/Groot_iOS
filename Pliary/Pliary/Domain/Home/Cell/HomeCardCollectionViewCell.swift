//
//  HomeCardCollectionViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 01/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Lottie

class HomeCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var plantView: AnimationView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let url = URL(string: "https://assets7.lottiefiles.com/packages/lf20_ydl0uM.json")!
//        let animation = Animation.named("plant1")
        
        Animation.loadedFrom(url: url, closure: { animation in
            self.plantView.animation = animation
            
            self.plantView.play()
            self.plantView.contentMode = .scaleAspectFill
            self.plantView.loopMode = .loop
        }, animationCache: nil)
        
    }

    func setUp(with: Plant) {
        plantView.play()
    }
    
}
