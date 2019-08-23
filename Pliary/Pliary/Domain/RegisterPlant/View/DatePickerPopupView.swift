//
//  DatePickerPopupView.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class DatePickerPopupView: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: RegisterEventDelegate?
    var type: RegisterRowType?
    
    static func instance(type: RegisterRowType) -> DatePickerPopupView {
        let view: DatePickerPopupView = UIView.createViewFromNib(nibName: DatePickerPopupView.identifier)
        view.type = type
        view.datePicker.maximumDate = Date()
        return view
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        removeFromSuperview()
    }
    
    @IBAction func tapCompleteButton(_ sender: Any) {
        guard let type = type else {
            removeFromSuperview()
            return
        }
        
        delegate?.registerEvent(event: .dateSelected(type: type, date: datePicker.date.getDayStartTime()))
        removeFromSuperview()
    }
}
