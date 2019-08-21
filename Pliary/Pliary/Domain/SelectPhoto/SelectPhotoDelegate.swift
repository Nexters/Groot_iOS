//
//  SelectPhotoDelegate.swift
//  Pliary
//
//  Created by jeewoong.han on 22/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation
import Photos

protocol SelectPhotoDelegate: class {
    func photoSelected(_ photoAsset: PHAsset)
}
