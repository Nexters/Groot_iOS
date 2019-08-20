//
//  HomeCellEventDelegate.swift
//  Pliary
//
//  Created by jeewoong.han on 15/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

protocol HomeEventDelegate: class {
    func homeEvent(_ plant: Plant, event: HomeEvent)
}

enum HomeEvent {
    case waterToPlant
}
