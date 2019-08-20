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
            let plant = Plant(type: .stuki, englishName: PlantEnglishName.stuki.rawValue, koreanName: PlantKoreanName.stuki.rawValue, nickName: nil, wateringInterval: 30)
            return plant
        case .eucalyptus:
            let plant = Plant(type: .eucalyptus, englishName: PlantEnglishName.eucalyptus.rawValue, koreanName: PlantKoreanName.eucalyptus.rawValue, nickName: nil, wateringInterval: 4)
            return plant
        case .sansevieria:
            let plant = Plant(type: .sansevieria, englishName: PlantEnglishName.sansevieria.rawValue, koreanName: PlantKoreanName.sansevieria.rawValue, nickName: nil, wateringInterval: 30)
            return plant
        case .monstera:
            let plant = Plant(type: .monstera, englishName: PlantEnglishName.monstera.rawValue, koreanName: PlantKoreanName.monstera.rawValue, nickName: nil, wateringInterval: 5)
            return plant
        case .parlourPalm:
            let plant = Plant(type: .parlourPalm, englishName: PlantEnglishName.parlourPalm.rawValue, koreanName: PlantKoreanName.parlourPalm.rawValue, nickName: nil, wateringInterval: 7)
            return plant
        case .elastica:
            let plant = Plant(type: .elastica, englishName: PlantEnglishName.elastica.rawValue, koreanName: PlantKoreanName.elastica.rawValue, nickName: nil, wateringInterval: 7)
            return plant
        case .travelersPalm:
            let plant = Plant(type: .travelersPalm, englishName: PlantEnglishName.travelersPalm.rawValue, koreanName: PlantKoreanName.travelersPalm.rawValue, nickName: nil, wateringInterval: 10)
            return plant
        case .schefflera:
            let plant = Plant(type: .schefflera, englishName: PlantEnglishName.schefflera.rawValue, koreanName: PlantKoreanName.schefflera.rawValue, nickName: nil, wateringInterval: 5)
            return plant
        case .userPlants:
            let plant = Plant(type: .userPlants, englishName: "", koreanName: nil, nickName: nil, wateringInterval: 3)
            return plant
        }
    }
}
