//
//  WateringDelayPopupSubview.swift
//  Pliary
//
//  Created by jeewoong.han on 15/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class WateringDelayPopupSubview: UIView {
    
    @IBOutlet weak var delayDatePickerView: UIPickerView!
    @IBOutlet weak var completeButton: UIButton!
    
    weak var delegate: WateringEventDelegate?
    private let values: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    private var currentValue: Int = 1
    
    static func instance() -> WateringDelayPopupSubview {
        let view: WateringDelayPopupSubview = UIView.createViewFromNib(nibName: WateringDelayPopupSubview.identifier)
        view.delayDatePickerView.delegate = view
        view.completeButton.clipsToBounds = true
        view.completeButton.layer.cornerRadius = 6
        return view
    }
    
    @IBAction func tapCompleteButton(_ sender: Any) {
        delegate?.wateringEvent(event: .completeToDelay(currentValue))
    }
    
}

extension WateringDelayPopupSubview: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentValue = values[row]
    }
}

extension WateringDelayPopupSubview: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
}
