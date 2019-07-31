//
//  SignUpViewController.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 23..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController,  UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        if let user = Auth.auth().currentUser {
            // 이미 login 상태
        }
        updateLoginButtonState()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButtonState()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        signUpButton.isEnabled = false
    }
    func updateLoginButtonState() {
        let email : String = emailTextField.text ?? ""
        let password : String = passwordTextField.text ?? ""
        signUpButton.isEnabled = isValidEmailAddress(email: email) && isValidPassword(password: password)
    }
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return predicate.evaluate(with: email)
    }
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[0-9])(?=.*[a-z]).{8}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }

    @IBAction func EmailSignUpButtonTouched(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else { return }
            
            if error == nil {
                // TODO: 회원가입 정상 처리 후 다음 로직, 로그인 페이지 or 바로 로그인 시키기
            } else {
                // TODO: 회원가입 실패
            }
        }
//        Auth.auth().createUser(withEmail: email, password: password) {
//            (authResult, error) in
//            guard let user = authResult?.user else { return }
//
//             print(user)
//            guard let error = AuthErrorCode(rawValue: (error?._code)!) else {
//                // Successfully signed up!
//                print(authResult)
//                return
//            }
//            // Error!
//            let manager :FirebaseAuthenticationManager = FirebaseAuthenticationManager.shared
//
//            manager.firebaseErrorHandle(code: error)

//        }
    }
}

