//
//  passwordResetPopupView.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 4..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class PasswordResetPopupView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // identifier
    class var identifier: String {
        return "PasswordResetPopupView"
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: self.identifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    @IBAction func PopupViewCloseButtonClick(_ sender: UIButton) {
        removeFromSuperview()
    }
}
