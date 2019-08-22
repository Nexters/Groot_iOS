//
//  WateringBackgroundView.swift
//  Pliary
//
//  Created by jeewoong.han on 15/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

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
            removeFromSuperview()
        }
    }
}
