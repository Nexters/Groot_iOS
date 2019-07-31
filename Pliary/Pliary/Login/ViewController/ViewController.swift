//
//  ViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 20/07/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signIn()
    }

    @IBOutlet weak var GIDSignInButton: GIDSignInButton!
    
    
}

