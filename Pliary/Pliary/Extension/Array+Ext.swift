//
//  Array+Ext.swift
//  Pliary
//
//  Created by jeewoong.han on 2020/11/28.
//  Copyright © 2020 groot.nexters.pliary. All rights reserved.
//

import Foundation

extension Array {
    
    subscript (safe index: Array.Index) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set {
            guard let element = newValue else { return }
            self[index] = element
        }
    }
}
