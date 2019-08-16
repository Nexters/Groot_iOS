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
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.setBottomBorder(color: Color.gray7)
        passwordTextField.setBottomBorder(color: Color.gray7)
        
        if let user = Auth.auth().currentUser {
            // 이미 login 상태
            return
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
        
        loginButton.isEnabled = true
    }
    
    @IBAction func EmailSIgnInButtonTouched(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            guard let error = AuthErrorCode(rawValue: (error?._code)!) else {
                // Successfully login!
                print(user)
                return
            }
            // Error!
            let manager :FirebaseAuthenticationManager = FirebaseAuthenticationManager.shared
            manager.firebaseErrorHandle(code: error)
        }
    }
    
    @IBAction func PopupViewLoad(_ sender: UIButton) {

        let popup = PasswordResetPopupView.instance()
        
        popup.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        popup.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        
        self.view.addSubview(popup);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}
