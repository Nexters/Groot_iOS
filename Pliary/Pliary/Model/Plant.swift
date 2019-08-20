//
//  Plant.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 31..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

struct Plant: Equatable {
    var type: PlantType
    var englishName: String
    var koreanName: String?
    var nickName: String?
    var wateringInterval: Int
    var firstDate: TimeInterval
    var lastWaterDate: TimeInterval
    
    init(type: PlantType, englishName: String, koreanName: String?, nickName: String?, wateringInterval: Int, firstDate: TimeInterval, lastWaterDate: TimeInterval) {
        self.type = type
        self.englishName = englishName
        self.koreanName = koreanName
        self.nickName = nickName
        self.wateringInterval = wateringInterval
        self.firstDate = firstDate
        self.lastWaterDate = lastWaterDate
    }
    
    func getTip() -> String {
        switch type {
        case .stuki:
            return PlantTip.stuki.rawValue
        case .eucalyptus:
            return PlantTip.eucalyptus.rawValue
        case .sansevieria:
            return PlantTip.sansevieria.rawValue
        case .monstera:
            return PlantTip.monstera.rawValue
        case .parlourPalm:
            return PlantTip.parlourPalm.rawValue
        case .elastica:
            return PlantTip.elastica.rawValue
        case .travelersPalm:
            return PlantTip.travelersPalm.rawValue
        case .schefflera:
            return PlantTip.schefflera.rawValue
        case .userPlants:
            return PlantTip.userPlants.rawValue
        }
    }
    
    func getPositiveImageName() -> String {
        switch type {
        case .stuki:
            return PlantPositiveImageName.stuki.rawValue
        case .eucalyptus:
            return PlantPositiveImageName.eucalyptus.rawValue
        case .sansevieria:
            return PlantPositiveImageName.sansevieria.rawValue
        case .monstera:
            return PlantPositiveImageName.monstera.rawValue
        case .parlourPalm:
            return PlantPositiveImageName.parlourPalm.rawValue
        case .elastica:
            return PlantPositiveImageName.elastica.rawValue
        case .travelersPalm:
            return PlantPositiveImageName.travelersPalm.rawValue
        case .schefflera:
            return PlantPositiveImageName.schefflera.rawValue
        case .userPlants:
            return PlantPositiveImageName.userPlants.rawValue
        }
    }
    
    func getNegativeImageName() -> String {
        switch type {
        case .stuki:
            return PlantNegativeImageName.stuki.rawValue
        case .eucalyptus:
            return PlantNegativeImageName.eucalyptus.rawValue
        case .sansevieria:
            return PlantNegativeImageName.sansevieria.rawValue
        case .monstera:
            return PlantNegativeImageName.monstera.rawValue
        case .parlourPalm:
            return PlantNegativeImageName.parlourPalm.rawValue
        case .elastica:
            return PlantNegativeImageName.elastica.rawValue
        case .travelersPalm:
            return PlantNegativeImageName.travelersPalm.rawValue
        case .schefflera:
            return PlantNegativeImageName.schefflera.rawValue
        case .userPlants:
            return PlantNegativeImageName.userPlants.rawValue
        }
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
