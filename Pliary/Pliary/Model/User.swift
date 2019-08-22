//
//  User.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 31..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import Foundation
import UserNotifications

struct User {
    
    var userId: String
    var idToken: String
    var fullName: String
    var givenName: String
    var familyName: String
    var email: String
    var photo: String?

    init(userId: String , idToken: String, fullName: String, givenName: String, familyName: String, email: String, photo: String) {
        self.userId = userId
        self.idToken = idToken
        self.fullName = fullName
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
        self.photo = photo
    }
    
    func registerNotification(){
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        var dates : Dictionary = [Int : String]()
        
        let plants = Global.shared.plants
        
        for plant in plants {
            let wateringInterval = plant.wateringInterval * 43200 // 60 * 60 * 12
            var wateringDay =  Int(plant.getNextWaterDate())
            
            var str = dates[wateringDay] ?? ""
            if(str == ""){
                str = plant.nickName
            } else {
                str += ", "
                str += plant.nickName
            }
            dates.updateValue(str, forKey: Int(wateringDay))
            
        }
        
        for (wateringDay, plantstr)  in dates {
            let content = UNMutableNotificationContent()
            
            content.title = "식물 물주기 알람"
            content.body = "오늘은 \(plantstr) 물 먹는 날!"
            content.sound = UNNotificationSound.default
            content.categoryIdentifier = "watering"
            
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: Date.init(timeIntervalSince1970: TimeInterval(wateringDay)))
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            let request = UNNotificationRequest(identifier: String(wateringDay), content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request){ (error) in
                if let error = error {
                    print("Error:\(error.localizedDescription)")
                }
            }
        }
    }
}
