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
import Kingfisher

class LoginViewController: UIViewController, GIDSignInUIDelegate{
    
    
    @IBOutlet weak var GIDSignInButton: UIButton!
    @IBOutlet weak var plantView: AnimatedImageView!
    
    @IBAction func GIDSignInButtonClicked(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func tapEmailSignInButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: StoryboardName.login, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: SignInViewController.identifier) as? SignInViewController else {
            return
        }
        
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .push(direction: .left)
        
        present(vc, animated: true, completion: nil)
    }
    
}

extension LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: ImageName.loginImage + ".gif")
        
        if let path = Bundle.main.path(forResource: ImageName.loginImage, ofType: "gif") {
            let url = URL(fileURLWithPath: path) 
            let provider = LocalFileImageDataProvider(fileURL: url)
            plantView.kf.setImage(with: provider, placeholder: image, options: nil, progressBlock: nil, completionHandler: { _ in })
        } else {
            plantView.image = image
        }
        
    }
}
