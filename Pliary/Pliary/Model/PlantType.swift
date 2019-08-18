//
//  PlantList.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

enum PlantType {
    case stuki
    case eucalyptus
    case sansevieria
    case monstera
    case parlourPalm
    case elastica
    case travelersPalm
    case schefflera
    case userPlants
    
    func getPlantInstance() -> Plant {
        switch self {
        case .stuki:
            let plant = Plant(type: .stuki, englishName: PlantEnglishName.stuki.rawValue, koreanName: PlantKoreanName.stuki.rawValue, nickName: nil, wateringDay: 30, imageName: PlantPositiveImageName.stuki.rawValue)
            return plant
        case .eucalyptus:
            let plant = Plant(type: .eucalyptus, englishName: PlantEnglishName.eucalyptus.rawValue, koreanName: PlantKoreanName.eucalyptus.rawValue, nickName: nil, wateringDay: 4, imageName: PlantPositiveImageName.stuki.rawValue)
            return plant
        case .sansevieria:
            let plant = Plant(type: .sansevieria, englishName: PlantEnglishName.sansevieria.rawValue, koreanName: PlantKoreanName.sansevieria.rawValue, nickName: nil, wateringDay: 30, imageName: PlantPositiveImageName.sansevieria.rawValue)
            return plant
        case .monstera:
            let plant = Plant(type: .monstera, englishName: PlantEnglishName.monstera.rawValue, koreanName: PlantKoreanName.monstera.rawValue, nickName: nil, wateringDay: 5, imageName: PlantPositiveImageName.monstera.rawValue)
            return plant
        case .parlourPalm:
            let plant = Plant(type: .parlourPalm, englishName: PlantEnglishName.parlourPalm.rawValue, koreanName: PlantKoreanName.parlourPalm.rawValue, nickName: nil, wateringDay: 7, imageName: PlantPositiveImageName.parlourPalm.rawValue)
            return plant
        case .elastica:
            let plant = Plant(type: .elastica, englishName: PlantEnglishName.elastica.rawValue, koreanName: PlantKoreanName.elastica.rawValue, nickName: nil, wateringDay: 7, imageName: PlantPositiveImageName.elastica.rawValue)
            return plant
        case .travelersPalm:
            let plant = Plant(type: .travelersPalm, englishName: PlantEnglishName.travelersPalm.rawValue, koreanName: PlantKoreanName.travelersPalm.rawValue, nickName: nil, wateringDay: 10, imageName: PlantPositiveImageName.travelersPalm.rawValue)
            return plant
        case .schefflera:
            let plant = Plant(type: .schefflera, englishName: PlantEnglishName.schefflera.rawValue, koreanName: PlantKoreanName.schefflera.rawValue, nickName: nil, wateringDay: 5, imageName: PlantPositiveImageName.schefflera.rawValue)
            return plant
        case .userPlants:
            let plant = Plant(type: .userPlants, englishName: "", koreanName: nil, nickName: nil, wateringDay: 0, imageName: PlantPositiveImageName.userPlants.rawValue)
            return plant
        }
    }
}
