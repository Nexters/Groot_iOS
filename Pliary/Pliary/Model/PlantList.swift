//
//  PlantList.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

enum PlantList {
    case stuki
    case eucalyptus
    case sansevieria
    case monstera
    case parlourPalm
    case elastica
    case travelersPalm
    case schefflera
    case userPlants
    
    static func getAllPlants() -> [Plant] {
        let stuki = PlantList.stuki.getPlantInstance()
        let eucalyptus = PlantList.eucalyptus.getPlantInstance()
        let sansevieria = PlantList.sansevieria.getPlantInstance()
        let monstera = PlantList.monstera.getPlantInstance()
        let parlourPalm = PlantList.parlourPalm.getPlantInstance()
        let elastica = PlantList.elastica.getPlantInstance()
        let travelersPalm = PlantList.travelersPalm.getPlantInstance()
        let schefflera = PlantList.schefflera.getPlantInstance()
        let userPlants = PlantList.userPlants.getPlantInstance()
        
        return [stuki, eucalyptus, sansevieria, monstera, parlourPalm, elastica, travelersPalm, schefflera, userPlants]
    }
    
    func getPlantInstance() -> Plant {
        switch self {
        case .stuki:
            let plant = Plant(englishName: PlantEnglishName.stuki.rawValue, koreanName: PlantKoreanName.stuki.rawValue, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.stuki.rawValue)
            return plant
        case .eucalyptus:
            let plant = Plant(englishName: PlantEnglishName.eucalyptus.rawValue, koreanName: PlantKoreanName.eucalyptus.rawValue, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.stuki.rawValue)
            return plant
        case .sansevieria:
            let plant = Plant(englishName: PlantEnglishName.sansevieria.rawValue, koreanName: PlantKoreanName.sansevieria.rawValue, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.sansevieria.rawValue)
            return plant
        case .monstera:
            let plant = Plant(englishName: PlantEnglishName.monstera.rawValue, koreanName: PlantKoreanName.monstera.rawValue, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.monstera.rawValue)
            return plant
        case .parlourPalm:
            let plant = Plant(englishName: PlantEnglishName.parlourPalm.rawValue, koreanName: PlantKoreanName.parlourPalm.rawValue, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.parlourPalm.rawValue)
            return plant
        case .elastica:
            let plant = Plant(englishName: PlantEnglishName.elastica.rawValue, koreanName: PlantKoreanName.elastica.rawValue, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.elastica.rawValue)
            return plant
        case .travelersPalm:
            let plant = Plant(englishName: PlantEnglishName.travelersPalm.rawValue, koreanName: PlantKoreanName.travelersPalm.rawValue, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.travelersPalm.rawValue)
            return plant
        case .schefflera:
            let plant = Plant(englishName: PlantEnglishName.schefflera.rawValue, koreanName: PlantKoreanName.schefflera.rawValue, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.schefflera.rawValue)
            return plant
        case .userPlants:
            let plant = Plant(englishName: "", koreanName: nil, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.userPlants.rawValue)
            return plant
        }
    }
}
