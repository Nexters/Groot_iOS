//
//  SignUpViewController.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 23..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let imagePickerController = UIImagePickerController()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailResetButton: UIButton!
    @IBOutlet weak var passwordResetButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var passwordGuideLabel: UILabel!
    @IBOutlet weak var emailGuideLabel: UILabel!
    @IBOutlet weak var emailWarningAlert: UIImageView!
    @IBOutlet weak var passwordWarningAlert: UIImageView!
    @IBOutlet weak var emailSuccessAlert: UIImageView!
    @IBOutlet weak var passwordSuccessAlert: UIImageView!
    @IBOutlet weak var userProfileImageView: UIImageView!


    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func emailResetButtonClick(_ sender: UIButton) {
        emailTextField.text = ""
    }
    @IBAction func passwordResetButtonClick(_ sender: UIButton) {
        passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        emailGuideLabel.frame.size = CGSize(width: 0, height: 0)
        emailTextField.setBottomBorder(color: UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0))
        passwordTextField.setBottomBorder(color: UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0))
        
        if let user = Auth.auth().currentUser {
            // 이미 login 상태
            return
        }
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
        emailResetButton.isHidden = false
        passwordResetButton.isHidden = false
    }

    func updateLoginButtonState() {
        let email : String = emailTextField.text ?? ""
        let password : String = passwordTextField.text ?? ""
        
        if !isValidEmailAddress(email: email) {
            emailResetButton.isHidden = true
            emailWarningAlert.isHidden = false
            emailSuccessAlert.isHidden = true
//            emailGuideLabel.isHidden = false
            emailGuideLabel.frame.size = CGSize(width: 303, height: 16)
            emailGuideLabel.text = "이메일 형식에 맞지 않습니다."
            emailGuideLabel.frame.size = CGSize(width: 303, height: 16)
        } else if isExistsEmail(email: email) {
            emailResetButton.isHidden = true
            emailWarningAlert.isHidden = false
            emailSuccessAlert.isHidden = true
//            emailGuideLabel.isHidden = false
            emailGuideLabel.frame.size = CGSize(width: 303, height: 16)
            emailGuideLabel.text = "이미 사용중인 이메일입니다."
        } else {
            emailGuideLabel.text = ""
            emailGuideLabel.frame.size = CGSize(width: 303, height: 0)
//            emailGuideLabel.isHidden = true
            emailResetButton.isHidden = true
            emailWarningAlert.isHidden = true
            emailSuccessAlert.isHidden = false
        }
        
        if isValidPassword(password: password) {
            passwordGuideLabel.frame.size = CGSize(width: 303, height: 0)
            passwordGuideLabel.text = ""
            passwordWarningAlert.isHidden = true
            passwordResetButton.isHidden = true
            passwordSuccessAlert.isHidden = false
        } else {
            passwordGuideLabel.frame.size = CGSize(width: 303, height: 16)
            passwordGuideLabel.text = "대문자, 소문자, 숫자 조합 8글자 이상"
            passwordWarningAlert.isHidden = false
            passwordResetButton.isHidden = true
            passwordSuccessAlert.isHidden = true
        }
        
        if isValidEmailAddress(email: email) && isValidPassword(password: password) {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(red: 106.0/255.0, green: 167.0/255.0, blue: 111.0/255.0, alpha: 1.0)
            
            signUpButton.layer.applySketchShadow(color: UIColor(red: 105.0/255.0, green: 146.0/255.0, blue: 117.0/255.0, alpha: 0.4), alpha: 0.4, x: 0, y: 10, blur: 14, spread: 0)
            signUpButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            signUpButton.isEnabled = false
            signUpButton.setTitleColor(UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1.0), for: .normal)
            signUpButton.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            signUpButton.layer.applySketchShadow(color: UIColor.white, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
        
    }
    
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return predicate.evaluate(with: email)
    }
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "\\A(?=[^A-Z]*[A-Z])(?=[^a-z]*[a-z])(?=\\D*\\d)\\S{8,}\\z"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    func isExistsEmail(email: String) -> Bool {
        // email 중복 체크
        return false
    }
    
    @IBAction func EmailSignUpButtonTouched(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
//        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
//            guard let user = authResult?.user else { return }
//
//            if error == nil {
//                // TODO: 회원가입 정상 처리 후 다음 로직, 로그인 페이지 or 바로 로그인 시키기
//                print("signup success")
//                print(error?.localizedDescription)
//            } else {
//                // TODO: 회원가입 실패
//                print("signup error")
//                print(error?.localizedDescription)
//            }
//        }
        do {
            try Auth.auth().useUserAccessGroup("groot.nexters.pliary.Pliary")
        } catch let error as NSError {
            print("Error changing user access group: %@", error)
        }
        
        

        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let error = AuthErrorCode(rawValue: (error?._code)!) else {
                // Successfully signed up!
                guard let user = authResult?.user else { return }
                print(user)
                return
            }
            // Error!
            let manager :FirebaseAuthenticationManager = FirebaseAuthenticationManager.shared
            manager.firebaseErrorHandle(code: error)
        }
    
    }
    
}

