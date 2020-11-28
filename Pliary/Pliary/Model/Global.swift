//
//  Global.swift
//  Pliary
//
//  Created by jeewoong.han on 17/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation
//import FirebaseAuth

class Global: NSObject {
    
    static let shared: Global = Global()
    
    var plants: [Plant] = [] {
        didSet {
            if oldValue != plants {
                saveCurrentPlants()
                UserNotification.watering.registerNotification(plants: plants)
            }
        }
    }
    
    var selectedPlant: Plant? {
        didSet {
            if oldValue != selectedPlant {
                NotificationCenter.default.post(name: NotificationName.reloadSelectedPlant, object: nil)
                NotificationCenter.default.post(name: NotificationName.reloadWateringRecord, object: nil)
            }
        }
    }
    
    var diaryDict: [String: [DiaryCard]] = [:] {
        didSet {
            if oldValue != diaryDict {
                saveDiaryCards()
                NotificationCenter.default.post(name: NotificationName.reloadDiaryCard, object: nil)
            }
        }
    }
    
    var waterRecordDict: [String: Set<TimeInterval>] = [:] {
        didSet {
            if oldValue != waterRecordDict {
                saveWateringRecord()
                NotificationCenter.default.post(name: NotificationName.reloadWateringRecord, object: nil)
            }
        }
    }
    
    private func saveCurrentPlants() {
        let encoder = JSONEncoder()
        var dict: [String: Any] = [:]
        for plant in plants {
            guard let data = try? encoder.encode(plant) else {
                continue
            }
            dict[plant.id] = data
        }
        AssetManager.save(data: dict, for: AssetKey.plants.rawValue)
    }
    
    private func saveDiaryCards() {
        let encoder = JSONEncoder()
        var dict: [String: Any] = [:]
        for key in diaryDict.keys {
            guard let data = try? encoder.encode(diaryDict[key]) else {
                continue
            }
            dict[key] = data
        }
        AssetManager.save(data: dict, for: AssetKey.diaryCard.rawValue)
    }
    
    private func saveWateringRecord() {
        AssetManager.save(data: waterRecordDict, for: AssetKey.wateringRecord.rawValue)
    }
    
    private func loadCurrentPlants() {
        let decoder = JSONDecoder()
        let dict = AssetManager.getDictData(for: AssetKey.plants.rawValue)
        var plantArray: [Plant] = []
        for key in dict.keys {
            let value = dict[key]
            if let data = value as? Data, let plant = try? decoder.decode(Plant.self, from: data) {
                plantArray.append(plant)
            }
        }
        
        plantArray = plantArray.sorted(by: { $0.nextWaterDate < $1.nextWaterDate })
        plants = plantArray
    }
    
    private func loadDiaryCards() {
        let decoder = JSONDecoder()
        let dict = AssetManager.getDictData(for: AssetKey.diaryCard.rawValue)
        var newDict: [String: [DiaryCard]] = [:]
        for key in dict.keys {
            let value = dict[key]
            if let data = value as? Data, let card = try? decoder.decode([DiaryCard].self, from: data) {
                newDict[key] = card
            }
        }
        diaryDict = newDict
    }
    
    private func loadWateringRecords() {
        if let dict = AssetManager.getDictData(for: AssetKey.wateringRecord.rawValue) as? [String: Set<TimeInterval>] {
            waterRecordDict = dict
        }
    }
    
    
    override init() {
        super.init()
        loadCurrentPlants()
        loadDiaryCards()
        loadWateringRecords()
    }
}
