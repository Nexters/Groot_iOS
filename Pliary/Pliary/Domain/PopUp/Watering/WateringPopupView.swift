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
        
        // negative or postive 계산 (d-day)
        guard let plant = plant else {
            return
        }
        
        let today = Date()
        let nextWaterDay = Date(timeIntervalSince1970: plant.nextWaterDate)
        
        if let dDay = daysBetween(start: today, end: nextWaterDay) {
            if dDay <= 0 {
                view.delayButton.alpha = 0.5
                view.delayButton.isEnabled = false
            }
        }
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
    
    func daysBetween(start: Date, end: Date) -> Int? {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)
    }

}

extension WateringPopupView: WateringEventDelegate {
    func wateringEvent(event: WateringEvent) {
        guard let plant = plant else {
            return
        }

        switch event {
        case .waterThePlant:
            var wateredPlant = plant
            wateredPlant.lastWaterDate = Date().getDayStartTime()
            wateredPlant.nextWaterDate = wateredPlant.recalculateNextWaterDate()

            var plants: [Plant] = []
            for plant in Global.shared.plants {
                if plant.id == wateredPlant.id {
                    plants.append(wateredPlant)
                } else {
                    plants.append(plant)
                }
            }
            
            UserNotification.watering.registerNotification()
            Global.shared.plants = plants

            if var dict = Global.shared.waterRecordDict[plant.id] {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM"
                let currentMonth = formatter.string(from: Date())
                if var monthSet = dict[currentMonth] {
                    monthSet.insert(Date().getDayStartTime())
                    dict[currentMonth] = monthSet
                } else {
                    dict[currentMonth] = [Date().getDayStartTime()]
                }

                Global.shared.waterRecordDict[plant.id] = dict
            }

            
            delegate?.plantEvent(plant, event: .completeToWater)
            removeFromSuperview()

        case .convertViewToDelay:
            setDelayView()

        case .completeToDelay(let day):
            
            // negative or postive 계산 (d-day)
            let today = Date()
            let nextWaterDay = Date(timeIntervalSince1970: plant.nextWaterDate)
            
            var delayedPlant = plant
            
            if let dDay = daysBetween(start: today, end: nextWaterDay) {
                if dDay <= 0 {
                    delayedPlant.nextWaterDate = today.getDayStartTime() + Double(day * 60 * 60 * 24)
                } else {
                    delayedPlant.nextWaterDate = delayedPlant.getDelayedWaterDate(day: day)
                }
            }

            var plants: [Plant] = []
            for plant in Global.shared.plants {
                if plant.id == delayedPlant.id {
                    plants.append(delayedPlant)
                } else {
                    plants.append(plant)
                }
            }
            
            UserNotification.watering.registerNotification()
            Global.shared.plants = plants
            removeFromSuperview()
        }
    }
}
