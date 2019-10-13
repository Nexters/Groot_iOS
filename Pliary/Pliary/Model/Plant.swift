//
//  Plant.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 31..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

struct Plant: Equatable, Codable {

    let id: String
    var type: PlantType
    var englishName: String
    var koreanName: String?
    var nickName: String
    var firstDate: TimeInterval
    // For watering
    var wateringInterval: Int
    var lastWaterDate: TimeInterval
    var nextWaterDate: TimeInterval

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case englishName
        case koreanName
        case nickName
        case wateringInterval
        case firstDate
        case lastWaterDate
        case nextWaterDate
    }

    init(type: PlantType, englishName: String, koreanName: String?, nickName: String, wateringInterval: Int, firstDate: TimeInterval, lastWaterDate: TimeInterval, nextWaterDate: TimeInterval) {
        id = UUID().uuidString
        self.type = type
        self.englishName = englishName
        self.koreanName = koreanName
        self.nickName = nickName
        self.wateringInterval = wateringInterval
        self.firstDate = firstDate
        self.lastWaterDate = lastWaterDate
        self.nextWaterDate = nextWaterDate
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(PlantType.self, forKey: .type)
        englishName = try values.decode(String.self, forKey: .englishName)
        koreanName = try values.decodeIfPresent(String.self, forKey: .koreanName)
        nickName = try values.decode(String.self, forKey: .nickName)
        wateringInterval = try values.decode(Int.self, forKey: .wateringInterval)
        firstDate = try values.decode(TimeInterval.self, forKey: .firstDate)
        lastWaterDate = try values.decode(TimeInterval.self, forKey: .lastWaterDate)
        nextWaterDate = try values.decode(TimeInterval.self, forKey: .nextWaterDate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(englishName, forKey: .englishName)
        try container.encodeIfPresent(koreanName, forKey: .koreanName)
        try container.encode(nickName, forKey: .nickName)
        try container.encode(wateringInterval, forKey: .wateringInterval)
        try container.encode(firstDate, forKey: .firstDate)
        try container.encode(lastWaterDate, forKey: .lastWaterDate)
        try container.encode(nextWaterDate, forKey: .nextWaterDate)
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
        case .hangingPlant:
            return PlantTip.hangingPlant.rawValue
        case .userPlants:
            return PlantTip.userPlants.rawValue
        }
    }

    func getRegisterImageName() -> String {
        switch type {
        case .stuki:
            return PlantRegisterImageName.stuki.rawValue
        case .eucalyptus:
            return PlantRegisterImageName.eucalyptus.rawValue
        case .sansevieria:
            return PlantRegisterImageName.sansevieria.rawValue
        case .monstera:
            return PlantRegisterImageName.monstera.rawValue
        case .parlourPalm:
            return PlantRegisterImageName.parlourPalm.rawValue
        case .elastica:
            return PlantRegisterImageName.elastica.rawValue
        case .travelersPalm:
            return PlantRegisterImageName.travelersPalm.rawValue
        case .schefflera:
            return PlantRegisterImageName.schefflera.rawValue
        case .hangingPlant:
            return PlantRegisterImageName.hangingPlant.rawValue
        case .userPlants:
            return PlantRegisterImageName.userPlants.rawValue
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
        case .hangingPlant:
            return PlantPositiveImageName.hangingPlant.rawValue
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
        case .hangingPlant:
            return PlantNegativeImageName.hangingPlant.rawValue
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
        let hangingPlant = PlantType.hangingPlant.getPlantInstance()
        let userPlants = PlantType.userPlants.getPlantInstance()

        return [stuki, eucalyptus, sansevieria, monstera, parlourPalm, elastica, travelersPalm, schefflera, hangingPlant, userPlants]
    }

    func getDelayedWaterDate(day : Int) -> TimeInterval {
        return nextWaterDate + Double(day * 60 * 60 * 24)
    }

    func recalculateNextWaterDate() -> TimeInterval {
        return lastWaterDate + Double(wateringInterval * 60 * 60 * 24)
    }
    
    func getNextWaterDate() -> TimeInterval {
        
        if(nextWaterDate != 0) {
            return nextWaterDate
        }
        if(lastWaterDate == 0) {
            let currentTimestamp = Date().getDayStartTime()
            return currentTimestamp + Double(wateringInterval * 60 * 60 * 24)
        } else {
            return lastWaterDate + Double(wateringInterval * 60 * 60 * 24)
        }
    }
}

