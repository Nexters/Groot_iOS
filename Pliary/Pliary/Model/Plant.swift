//
//  Plant.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 31..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import Foundation

struct Plant {

    var mainName: String
    var subName: String?
    var nickName: String?
    var wateringDay: Int
    var imageName: String?
    init(mainName: String, subName: String?, nickName: String?, wateringDay: Int, imageName: String?) {
        self.mainName = mainName
        self.subName = subName
        self.nickName = nickName
        self.wateringDay = wateringDay
        self.imageName = imageName
    }
}
