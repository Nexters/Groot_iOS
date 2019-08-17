//
//  SendCompletePopupView.swift
//  Pliary
//
//  Created by jueun lee on 17/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class SendCompletePopupView: UIView {

    class func instance() -> UIView {
        let view: SendCompletePopupView = UIView.createViewFromNib(nibName: SendCompletePopupView.identifier)
        return view
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
