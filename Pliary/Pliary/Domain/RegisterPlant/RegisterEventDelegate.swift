//
//  RegisterEventDelegate.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

protocol RegisterEventDelegate: class {
    func registerEvent(event: RegisterEvent)
}

enum RegisterEvent {
    case selectPlant
    case selectDate
    case plantSelected
}
