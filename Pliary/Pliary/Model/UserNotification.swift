//
//  PlantNotification.swift
//  Pliary
//
//  Created by jueun lee on 23/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation
import UserNotifications

enum UserNotification {
    
    case watering
  
    func registerNotification(plants: [Plant]){
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        var dateDic : Dictionary = [Int : String]()
        
        for plant in plants {
            let waterDate =  Int(plant.getNextWaterDate()) + 60 * 60 * 8
            
            var plantNames = dateDic[waterDate] ?? ""
            if(plantNames == ""){
                plantNames = plant.nickName
            } else {
                plantNames += ", "
                plantNames += plant.nickName
            }
            dateDic.updateValue(plantNames, forKey: Int(waterDate))
        }
        
        for (waterDate, plantNames)  in dateDic {
            let content = UNMutableNotificationContent()
            
            content.title = "식물 물주기 알람"
            
            let numbrtOfPlant = plantNames.split(separator: ",").count
            
            if(numbrtOfPlant > 3) {
                
                let plants = plantNames.split(separator: ",")
                
                var names = String(plants.first ?? "")
                for i in (1...2) {
                    names.append(",")
                    names.append(String(plants[i]))
                }
                content.body = "오늘은 \(names) 외 \(numbrtOfPlant - 3)개 물 먹는 날!"
                
            } else {
                
                content.body = "오늘은 \(plantNames) 물 먹는 날!"
            }
            content.sound = UNNotificationSound.default
            content.categoryIdentifier = "watering"
            
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: Date.init(timeIntervalSince1970: TimeInterval(waterDate)))
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            let request = UNNotificationRequest(identifier: String(waterDate), content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error:\(error.localizedDescription)")
                }
            }
        }
    }
}
