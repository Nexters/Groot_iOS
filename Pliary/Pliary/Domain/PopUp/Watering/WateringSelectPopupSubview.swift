//
//  WateringSelectPopupSubview.swift
//  Pliary
//
//  Created by jeewoong.han on 15/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class WateringSelectPopupSubview: UIView {

    @IBOutlet weak var delayButton: UIButton!
    @IBOutlet weak var wateringButton: UIButton!
    
    weak var delegate: WateringEventDelegate?
    
    static func instance() -> WateringSelectPopupSubview {
        let view: WateringSelectPopupSubview = UIView.createViewFromNib(nibName: WateringSelectPopupSubview.identifier)
        
        view.delayButton.clipsToBounds = true
        view.delayButton.layer.cornerRadius = 6
        view.delayButton.layer.borderWidth = 1.5
        view.delayButton.layer.borderColor = view.wateringButton.backgroundColor?.cgColor
        
        view.wateringButton.clipsToBounds = true
        view.wateringButton.layer.cornerRadius = 6
        
        return view
    }
    
    @IBAction func tapDelayButton(_ sender: Any) {
        delegate?.wateringEvent(event: .convertViewToDelay)
    }
    
    @IBAction func tapWateringButton(_ sender: Any) {
        delegate?.wateringEvent(event: .waterThePlant)
    }
    
}
