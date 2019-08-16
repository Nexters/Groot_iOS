//
//  WateringPopupView.swift
//  Pliary
//
//  Created by jueun lee on 14/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class WateringPopupView: UIView {

    @IBAction func closeButtonClicked(_ sender: Any) {
        removeFromSuperview()
    }
    
//    @IBOutlet weak var mainLabel: UILabel!
//    @IBOutlet weak var subLabel: UILabel!
//    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var daySettingView: UIView!
//    @IBOutlet weak var wateringButton: UIButton!
//    @IBOutlet weak var delayButton: UIButton!
//    @IBOutlet weak var daySettingButton: UIButton!
//    
//    @IBAction func delayButtonClicked(_ sender: Any) {
//        chandeView(isDaySetting: true)
//    }
//    @IBAction func wateringButtonClicked(_ sender: Any) {
//    }
//    
//    @IBAction func daySettingButtonClicked(_ sender: Any) {
//    }
//    
//    func chandeView(isDaySetting : Bool){
//        
//        if isDaySetting {
//            mainLabel.text = "미룰 날짜를 입력해주세요."
//        } else {
//            mainLabel.text = "화분 흙의 습도를 확인해주세요."
//        }
//        subLabel.isHidden = isDaySetting
//        wateringButton.isHidden = isDaySetting
//        delayButton.isHidden = isDaySetting
//        daySettingButton.isHidden = !isDaySetting
//    }
    
}
