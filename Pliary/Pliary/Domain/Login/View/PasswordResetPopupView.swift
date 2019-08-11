//
//  passwordResetPopupView.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 4..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class PasswordResetPopupView: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: PasswordResetPopupView.identifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    @IBAction func PopupViewCloseButtonClick(_ sender: UIButton) {
        removeFromSuperview()
    }
    
}
