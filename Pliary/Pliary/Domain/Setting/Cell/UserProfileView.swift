//
//  UserProfileView.swift
//  Pliary
//
//  Created by jeewoong.han on 10/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class UserProfileView: UIView {
    
    static func instance() -> UserProfileView {
        let view: UserProfileView = UIView.createViewFromNib(nibName: UserProfileView.identifier)
        return view
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBAction func tabCameraButton(_ sender: Any) {
        
    }
    
}