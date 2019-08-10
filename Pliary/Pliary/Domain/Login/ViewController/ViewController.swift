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

class ViewController: UIViewController, GIDSignInUIDelegate{
    @IBOutlet weak var GIDSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GIDSignInButtonClicked(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }


    
}

