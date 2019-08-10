//
//  UICollectionViewCell+Ext.swift
//  Pliary
//
//  Created by jeewoong.han on 01/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    class var reuseIdentifier: String { return String(describing: self) }
}
