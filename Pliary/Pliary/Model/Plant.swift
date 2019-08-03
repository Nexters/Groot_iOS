//
//  Plant.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 31..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class Plant: NSObject {

    var name: String
    var species: String
    var drinkingDay: Int

    init(name: String, species: String, drinkingDay: Int) {
        self.name = name
        self.species = species
        self.drinkingDay = drinkingDay
    }
}
