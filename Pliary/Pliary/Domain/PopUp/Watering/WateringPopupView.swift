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

            UserNotification.watering.registerNotification()
            removeFromSuperview()

        case .convertViewToDelay:
            setDelayView()

        case .completeToDelay(let day):

            var delayedPlant = plant
            delayedPlant.nextWaterDate = delayedPlant.getDelayedWaterDate(day: day)

            var plants: [Plant] = []
            for plant in Global.shared.plants {
                if plant.id == delayedPlant.id {
                    plants.append(delayedPlant)
                } else {
                    plants.append(plant)
                }
            }
            UserNotification.watering.registerNotification()
            removeFromSuperview()
        }
    }
}
