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
    
    let uuid: String
    
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
    
    func clearUnusedImageSource() {
        var imageSet: Set<String> = Set()
        for diaryCards in diaryDict.values {
            for card in diaryCards {
                if let urlString = card.imageURL, let imageName = urlString.split(separator: "/").last {
                    imageSet.insert(String(imageName))
                }
            }
        }
        
        AssetManager.deleteAllImages(except: imageSet)
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
    
    private func getSizeOfUserDefaults() -> String? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return nil
        }
        
        let size = try? directory.sizeOnDisk()
        return size
    }
    
    private func getUUID() -> String {
        let key = AssetKey.uuid.rawValue
        if let uuid = AssetManager.getString(for: key) {
            return uuid
        } else {
            let uuid = UUID().uuidString
            AssetManager.save(string: uuid, for: key)
            clearUnusedImageSource()
            return uuid
        }
    }
    
    private func uploadSizeIfNeeded() {
        let key = AssetKey.totalImageSize.rawValue
        guard let realSize = getSizeOfUserDefaults() else {
            return
        }
        let savedSize = AssetManager.getString(for: key)
        print(realSize)
        if realSize != savedSize {
            DatabaseManager.uploadTotalImageSize(uuid: uuid, value: realSize)
            AssetManager.save(string: realSize, for: key)
        }
    }
    
    override init() {
        let key = AssetKey.uuid.rawValue
        if let uuidString = AssetManager.getString(for: key) {
            uuid = uuidString
        } else {
            let uuidString = UUID().uuidString
            AssetManager.save(string: uuidString, for: key)
            uuid = uuidString
        }
        
        super.init()
        loadCurrentPlants()
        loadDiaryCards()
        loadWateringRecords()
        uploadSizeIfNeeded()
    }
}
