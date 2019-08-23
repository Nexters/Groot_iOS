//
//  WateringBackgroundView.swift
//  Pliary
//
//  Created by jeewoong.han on 15/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import UserNotifications

class WateringPopupView: UIView {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var customView: UIView!
    
    weak var delegate: PlantEventDelegate?
    var plant: Plant?
    
    static func instance(with plant: Plant) -> WateringPopupView {
        let view: WateringPopupView = UIView.createViewFromNib(nibName: WateringPopupView.identifier)
        view.backgroundView.clipsToBounds = true
        view.backgroundView.layer.cornerRadius = 6
        view.plant = plant
        
        return view
    }
    
    private func clearCustomView() {
        customView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func setSelectView() {
        let view = WateringSelectPopupSubview.instance()
        view.frame = CGRect(origin: .zero, size: customView.frame.size)
        view.delegate = self
        
        clearCustomView()
        customView.addSubview(view)
    }
    
    func setDelayView() {
        let view = WateringDelayPopupSubview.instance()
        view.frame = CGRect(origin: .zero, size: customView.frame.size)
        view.delegate = self
        
        clearCustomView()
        customView.addSubview(view)
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        removeFromSuperview()
    }
    
}

extension WateringPopupView: WateringEventDelegate {
    func wateringEvent(event: WateringEvent) {
        guard let plant = plant else {
            return
        }
        
        switch event {
        case .waterThePlant:
            delegate?.plantEvent(plant, event: .completeToWater)
            for var wateringPlant in Global.shared.plants {
                var plants: [Plant] = []
                if wateringPlant.id == plant.id {
                    wateringPlant.water()
                    plants.append(wateringPlant)
                } else {
                    plants.append(wateringPlant)
                }
            }
            
            UserNotification.watering.registerNotification()
            removeFromSuperview()
        case .convertViewToDelay:
            setDelayView()
        case .completeToDelay(let day):
            var plants: [Plant] = []
            for var delayingPlant in Global.shared.plants {
                if delayingPlant.id == plant.id {
                    delayingPlant.delay(day: day)
                    plants.append(delayingPlant)
                } else {
                    plants.append(delayingPlant)
                }
                
            }
            UserNotification.watering.registerNotification()
            removeFromSuperview()
        }
    }
}

extension WateringPopupView {
    
    func registerNotification(){
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let plants = Global.shared.plants
        var dateDic : Dictionary = [Int : String]()
        
        for plant in plants {
            let waterDate =  Int(plant.getNextWaterDate())
            
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
            if(numbrtOfPlant == 1) {
                
                content.body = "\(plantNames): 목이 조금 마릅니다만..?"
                
            } else if(numbrtOfPlant > 3) {
                
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
            
            print(content.body)
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: Date.init(timeIntervalSince1970: TimeInterval(waterDate)))
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            let request = UNNotificationRequest(identifier: String(waterDate), content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request){ (error) in
                if let error = error {
                    print("Error:\(error.localizedDescription)")
                }
            }
        }
    }
}
