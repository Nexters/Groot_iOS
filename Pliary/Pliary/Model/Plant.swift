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
    var wateringInterval: Int
    var firstDate: TimeInterval
    var waterDates: String
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
        case waterDates
    }

    init(type: PlantType, englishName: String, koreanName: String?, nickName: String, wateringInterval: Int, firstDate: TimeInterval, waterDates: String, lastWaterDate: TimeInterval, nextWaterDate: TimeInterval) {
        id = UUID().uuidString
        self.type = type
        self.englishName = englishName
        self.koreanName = koreanName
        self.nickName = nickName
        self.wateringInterval = wateringInterval
        self.firstDate = firstDate
        self.waterDates = waterDates
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
        waterDates = try values.decode(String.self, forKey: .waterDates)
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
        try container.encode(waterDates, forKey: .waterDates)
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

    mutating func water() {
        let currentTimestamp = Date().timeIntervalSince1970
        let currentDateStr: String = currentTimestamp.getSince1970String()
        
        if getWaterDates().contains(currentDateStr) {
            return
        }
        self.waterDates.append("|")
        self.waterDates.append(currentDateStr)
        self.lastWaterDate = currentTimestamp
    }

    mutating func delay(day : Int) {
        self.nextWaterDate = getNextWaterDate() + Double(day * 86400) // 60 * 60 * 24
    }

    func getNextWaterDate() -> TimeInterval {
        
        if(nextWaterDate != 0) {
            return nextWaterDate
        }
        else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy.MM.dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "KST") as TimeZone?
            
            let currentTimestamp = Date().timeIntervalSince1970
            let currentDateStr: String = currentTimestamp.getSince1970String() + " 08:00:00"
            let currentDate: Date = dateFormatter.date(from: currentDateStr) ?? Date()
            
            if(lastWaterDate == 0) {
                
                return currentDate.timeIntervalSince1970 + Double(wateringInterval * 86400) // 60 * 60 * 24
                
            } else {
                
                let lastDateString: String = lastWaterDate.getSince1970String() + " 08:00:00"
                let lastDate: Date = dateFormatter.date(from: lastDateString) ?? Date()
                let lastDateTimestamp = lastDate.timeIntervalSince1970

                if(lastDateTimestamp < currentTimestamp){
                    return currentDate.timeIntervalSince1970 + Double(wateringInterval * 86400) // 60 * 60 * 24
                }
                return lastDate.timeIntervalSince1970
            }
        }
    }
    
    func getWaterDatesTodo() -> [String] {
        
        let interval = self.wateringInterval * 86400 // 60 * 60 * 24
        var waterDate : Int = Int(self.getNextWaterDate())
        var datesTodo = [String]()
        let twoMonthDay = waterDate + 5184000 // 60 * 60 * 24 * 30 * 2 // 2 month
        
        while waterDate < twoMonthDay {
            waterDate += interval
            let date = Date(timeIntervalSince1970: TimeInterval(waterDate))
            datesTodo.append(formatter.string(from: date))
        }
        
        return datesTodo
    }
    
    func getWaterDates() -> [String] {
        var dates = [String]()
        let waterDates = self.waterDates.split(separator: "|")
        for date in waterDates {
            dates.append(String(date))
        }
        return dates
    }
    
    func getDayLeft() -> String {
        let currnt = Date().timeIntervalSince1970
        let next = TimeInterval(self.getNextWaterDate())
        let interval = Int(next - currnt)
        
        let days = Int(interval / 86400) + 1
        return String(days)
    }
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
}
