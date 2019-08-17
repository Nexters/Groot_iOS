//
//  Global.swift
//  Pliary
//
//  Created by jeewoong.han on 17/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

class Global: NSObject {
    static let shared: Global = Global()
    
    var user: User?
    
    override init() {
        super.init()
        
        
    }
}
