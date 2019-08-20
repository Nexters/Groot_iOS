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
    
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet private weak var headerFixedArrowImage: UIImageView!
    @IBOutlet private weak var nonHeaderFixedArrowImage: UIImageView!
    
    weak var delegate: RegisterEventDelegate?
    
    static func instance() -> RegisterPlantHeaderView {
        let view: RegisterPlantHeaderView = UIView.createViewFromNib(nibName: RegisterPlantHeaderView.identifier)
        view.headerFixed(bool: false)
        return view
    }
    
    @IBAction func tapPlantNameButton(_ sender: Any) {
        delegate?.registerEvent(event: .selectPlant)
    }
    
    func headerFixed(bool: Bool) {
        if bool {
            nonHeaderFixedArrowImage.isHidden = true
            headerFixedArrowImage.isHidden = false
        } else {
            nonHeaderFixedArrowImage.isHidden = false
            headerFixedArrowImage.isHidden = true
        }
    }
}
