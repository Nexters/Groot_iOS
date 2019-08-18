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
    
    static func instance() -> DatePickerPopupView {
        let view: DatePickerPopupView = UIView.createViewFromNib(nibName: DatePickerPopupView.identifier)
        
        return view
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        removeFromSuperview()
    }
    
    @IBAction func tapCompleteButton(_ sender: Any) {
        removeFromSuperview()
    }
}
