//
//  UIImageView+Ext.swift
//  Pliary
//
//  Created by jeewoong.han on 22/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Photos

extension UIImageView {
    func fetchHighQualityImage(asset: PHAsset) {
        let options = PHImageRequestOptions()
        options.version = .current
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: asset, targetSize: frame.size, contentMode: .aspectFill, options: options, resultHandler: { [weak self] (image : UIImage?, _) in
            guard let image = image else {
                self?.image = UIImage()
                return
            }
            
            self?.contentMode = .scaleAspectFill
            self?.image = image
        })
    }
    
    func fetchOpportunisticImage(asset: PHAsset) {
        let options = PHImageRequestOptions()
        options.version = .current
        options.deliveryMode = .opportunistic
        options.isSynchronous = false
        options.isNetworkAccessAllowed = true
        
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: asset, targetSize: frame.size, contentMode: .aspectFill, options: options, resultHandler: { [weak self] (image : UIImage?, _) in
            guard let image = image else {
                self?.image = UIImage()
                return
            }
            
            self?.contentMode = .scaleAspectFill
            self?.image = image
        })
    }
    
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        let options = PHImageRequestOptions()
        options.version = .current
        options.deliveryMode = .opportunistic
        options.isSynchronous = false
        options.isNetworkAccessAllowed = true
        
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: { [weak self] (image : UIImage?, _) in
            completion(image)
            guard let image = image else {
                self?.image = UIImage()
                return
            }
            
            switch contentMode {
            case .aspectFill:
                self?.contentMode = .scaleAspectFill
            case .aspectFit:
                self?.contentMode = .scaleAspectFit
            @unknown default:
                ()
            }
            
            self?.image = image
        })
    }
}
