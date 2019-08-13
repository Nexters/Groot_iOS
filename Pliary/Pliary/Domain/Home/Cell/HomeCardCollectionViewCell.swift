//
//  HomeCardCollectionViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 01/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import SwiftyGif

class HomeCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var plantView: UIImageView!
    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var dayLeftLabel: UILabel!
    @IBOutlet weak var blackWaterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        do {
            let gif = try UIImage(gifName: "plant1.gif", levelOfIntegrity:0.3)
            plantView.setGifImage(gif)
            plantView.startAnimatingGif()
        } catch {
            print(error)
        }
        
    }

    func setUp(with: Plant) {
        
    }
    
}
