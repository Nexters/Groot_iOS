//
//  RegisterPlantHeaderView.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class RegisterPlantHeaderView: UIView {

    static let height: CGFloat = 80
    weak var delegate: RegisterEventDelegate?
    
    static func instance() -> RegisterPlantHeaderView {
        let view: RegisterPlantHeaderView = UIView.createViewFromNib(nibName: RegisterPlantHeaderView.identifier)
        
        return view
    }
    
    @IBAction func tapPlantNameButton(_ sender: Any) {
        delegate?.registerEvent(event: .selectPlant)
    }
    
    @IBAction func tapArrowButton(_ sender: Any) {
        delegate?.registerEvent(event: .selectPlant)
    }
    
}
