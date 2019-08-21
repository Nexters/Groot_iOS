//
//  BasicToastView.swift
//  Pliary
//
//  Created by jueun lee on 21/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class BasicToastView: UIView {

    @IBOutlet weak var label: UILabel!

    class func instance() -> BasicToastView {
        let view: BasicToastView = UIView.createViewFromNib(nibName: BasicToastView.identifier)
        return view
    }

    func setUp(with text : String) {
        label.text = text
    }
}
