//
//  Plant.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 31..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import Foundation

struct Plant {
    var englishName: String
    var koreanName: String?
    var nickName: String?
    var wateringDay: Int
    var imageName: String
    init(englishName: String, koreanName: String?, nickName: String?, wateringDay: Int, imageName: String) {
        self.englishName = englishName
        self.koreanName = koreanName
        self.nickName = nickName
        self.wateringDay = wateringDay
        self.imageName = imageName
    }
}
