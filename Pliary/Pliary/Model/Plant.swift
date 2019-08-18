//
//  Plant.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 31..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import Foundation

struct Plant: Equatable {
    var type: PlantType
    var englishName: String
    var koreanName: String?
    var nickName: String?
    var wateringDay: Int
    var imageName: String
    
    init(type: PlantType, englishName: String, koreanName: String?, nickName: String?, wateringDay: Int, imageName: String) {
        self.type = type
        self.englishName = englishName
        self.koreanName = koreanName
        self.nickName = nickName
        self.wateringDay = wateringDay
        self.imageName = imageName
    }
    
    static func getAllPlants() -> [Plant] {
        let stuki = PlantType.stuki.getPlantInstance()
        let eucalyptus = PlantType.eucalyptus.getPlantInstance()
        let sansevieria = PlantType.sansevieria.getPlantInstance()
        let monstera = PlantType.monstera.getPlantInstance()
        let parlourPalm = PlantType.parlourPalm.getPlantInstance()
        let elastica = PlantType.elastica.getPlantInstance()
        let travelersPalm = PlantType.travelersPalm.getPlantInstance()
        let schefflera = PlantType.schefflera.getPlantInstance()
        let userPlants = PlantType.userPlants.getPlantInstance()
        
        return [stuki, eucalyptus, sansevieria, monstera, parlourPalm, elastica, travelersPalm, schefflera, userPlants]
    }
}
