//
//  RegisterEventDelegate.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

enum RegisterRowType {
    case englishName
    case koreanName
    case customName
    case image
    case startDate
    case lastWaterDate
    case period
}


protocol RegisterCell: class {
    func setUp(with plant: Plant, type: RegisterRowType)
}

protocol RegisterEventDelegate: class {
    func registerEvent(event: RegisterEvent)
}

enum RegisterEvent {
    case selectPlant
    case selectDate
    case plantSelected(plant: Plant)
}
