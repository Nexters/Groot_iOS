//
//  WateringEventProtocol.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

protocol WateringEventDelegate: class {
    func wateringEvent(event: WateringEvent)
}

enum WateringEvent {
    case waterThePlant
    case convertViewToDelay
    case completeToDelay(_ day: Int)
}
