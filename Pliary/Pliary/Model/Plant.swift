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
    var wateringDay: Int
    
    init(type: PlantType, englishName: String, koreanName: String?, nickName: String?, wateringDay: Int) {
        self.type = type
        self.englishName = englishName
        self.koreanName = koreanName
        self.nickName = nickName
        self.wateringDay = wateringDay
    }
    
    func getPositiveImage() -> UIImage? {
        switch type {
        case .stuki:
            return UIImage(named: PlantPositiveImageName.stuki.rawValue)
        case .eucalyptus:
            return UIImage(named: PlantPositiveImageName.eucalyptus.rawValue)
        case .sansevieria:
            return UIImage(named: PlantPositiveImageName.sansevieria.rawValue)
        case .monstera:
            return UIImage(named: PlantPositiveImageName.monstera.rawValue)
        case .parlourPalm:
            return UIImage(named: PlantPositiveImageName.parlourPalm.rawValue)
        case .elastica:
            return UIImage(named: PlantPositiveImageName.elastica.rawValue)
        case .travelersPalm:
            return UIImage(named: PlantPositiveImageName.travelersPalm.rawValue)
        case .schefflera:
            return UIImage(named: PlantPositiveImageName.schefflera.rawValue)
        case .userPlants:
            return UIImage(named: PlantPositiveImageName.userPlants.rawValue)
        }
    }
    
    func getNegativeImage() -> UIImage? {
        switch type {
        case .stuki:
            return UIImage(named: PlantNegativeImageName.stuki.rawValue)
        case .eucalyptus:
            return UIImage(named: PlantNegativeImageName.eucalyptus.rawValue)
        case .sansevieria:
            return UIImage(named: PlantNegativeImageName.sansevieria.rawValue)
        case .monstera:
            return UIImage(named: PlantNegativeImageName.monstera.rawValue)
        case .parlourPalm:
            return UIImage(named: PlantNegativeImageName.parlourPalm.rawValue)
        case .elastica:
            return UIImage(named: PlantNegativeImageName.elastica.rawValue)
        case .travelersPalm:
            return UIImage(named: PlantNegativeImageName.travelersPalm.rawValue)
        case .schefflera:
            return UIImage(named: PlantNegativeImageName.schefflera.rawValue)
        case .userPlants:
            return UIImage(named: PlantNegativeImageName.userPlants.rawValue)
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
