//
//  SendCompletePopupView.swift
//  Pliary
//
//  Created by jueun lee on 17/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class BasicPopupView: UIView {

    @IBOutlet weak var label: UILabel!
    class func instance() -> BasicPopupView {
        let view: BasicPopupView = UIView.createViewFromNib(nibName: BasicPopupView.identifier)
        return view
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    func setUp(with text : String) {
        label.text = text
    }
}
