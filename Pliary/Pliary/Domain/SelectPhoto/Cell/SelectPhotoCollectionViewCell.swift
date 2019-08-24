//
//  SelectPhotoCollectionViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 22/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Photos

class SelectPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var checkedImage: UIImageView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var photo = PHAsset()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uncheck()
    }
    
    func setUp(with photo: PHAsset) {
        self.photo = photo
        
        imageView.fetchImage(asset: photo, contentMode: .aspectFill, targetSize: imageView.frame.size, completion: { _ in
            
        })
        
        if isSelected {
            check()
        } else {
            uncheck()
        }
    }
    
    func check() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.borderColor = Color.green.cgColor
        view.layer.borderWidth = 3
        checkedImage.isHidden = false
    }
    
    func uncheck() {
        view.layer.borderWidth = 0
        view.backgroundColor = .clear
        checkedImage.isHidden = true
    }
}

