//
//  LoginViewController.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 22..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Firebase
import Hero


class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func BackButton(_ sender: Any) {
        hero.modalAnimationType = .pull(direction: .right)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func EmailSIgnInButtonTouched(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        do {
            try Auth.auth().useUserAccessGroup("groot.nexters.pliary.Pliary")
        } catch let error as NSError {
            print("Error changing user access group: %@", error)
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let error = AuthErrorCode(rawValue: (error?._code)!) else {
                // Successfully login!
//                Global.shared.user?.email = Auth.auth().currentUser?.email ?? ""
                
                let storyboard = UIStoryboard.init(name: StoryboardName.home, bundle: nil)
                guard storyboard.instantiateViewController(withIdentifier: HomeViewController.identifier) is HomeViewController else {
                    return
                }
                return
            }
            // Error!
            let manager :FirebaseAuthenticationManager = FirebaseAuthenticationManager.shared
            manager.firebaseErrorHandle(code: error)
        }
    }
    
    @IBAction func tapEmailSignUpButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: StoryboardName.login, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: SignUpViewController.identifier) as? SignUpViewController else {
            return
        }
        
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .push(direction: .left)
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        let velocity = gr.velocity(in: view)
        
        switch gr.state {
        case .began:
            hero.modalAnimationType = .pull(direction: .right)
            if velocity.x > 0 {
                dismiss(animated: true, completion: nil)
            }
        case .changed:
            Hero.shared.update(translation.x / view.bounds.width)
        default:
            if ((translation.x + velocity.x) / view.bounds.width) > 0.65 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField.isEqual(emailTextField)) {
            passwordTextField.becomeFirstResponder()
        } else if(textField.isEqual(passwordTextField)) {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButtonState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginButton.isEnabled = false
    }
    
    func updateLoginButtonState() {
        let email : String = emailTextField.text ?? ""
        let password : String = passwordTextField.text ?? ""
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = Color.green
        loginButton.layer.applySketchShadow(color: UIColor(red: 105.0/255.0, green: 146.0/255.0, blue: 117.0/255.0, alpha: 0.4), alpha: 0.4, x: 0, y: 10, blur: 14, spread: 0)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.isEnabled = true
    }
    
}

extension SignInViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.setBottomBorder(color: Color.gray7)
        passwordTextField.setBottomBorder(color: Color.gray7)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        view.addGestureRecognizer(gesture)
        
    }
}
