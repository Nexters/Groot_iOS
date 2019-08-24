//
//  HomeCellEventDelegate.swift
//  Pliary
//
//  Created by jeewoong.han on 15/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

protocol PlantEventDelegate: class {
    func plantEvent(_ plant: Plant, event: PlantEvent)
}

enum PlantEvent {
    case waterToPlant
    case completeToWater
    case completeToDelay
    case modifyOrDeletePlant
}
