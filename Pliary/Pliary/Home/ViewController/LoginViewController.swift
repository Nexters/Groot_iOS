//
//  LoginViewController.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 22..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Firebase


class SignInViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
     // @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Do any additional setup after loading the view.
       
        if let user = Auth.auth().currentUser {
            // 이미 login 상태
            mainView()
            return
        }
        updateLoginButtonState()
    }
    
    private func mainView(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window! = MainViewController
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
        loginButton.isEnabled = false
    }
    func updateLoginButtonState() {
        let email : String = emailTextField.text ?? ""
        let password : String = passwordTextField.text ?? ""
        
        loginButton.isEnabled = isExistsEmail(email: email)
    }
    func isExistsEmail(email: String) -> Bool {
        // email 중복 체크
        return true
    }

    func refreshInterface(){
        
        if let currentUser = GIDSignIn.sharedInstance().currentUser {

            // Sign In
            loginButton.isHidden = true
            signOutButton.isHidden = false
            labelRes.text = currentUser.profile.email
            
            if let url = currentUser.profile.imageURL(withDimension: 175),let data = NSData(contentsOf: url){
                
                userImage.image = UIImage(data: data as Data)
                
                userImage.isHidden = false
                
            }
            
        } else {
            
            signInButton.isHidden = false
            
            signOutButton.isHidden = true
            
            labelRes.text = "Welcom, Please Sign-In first."
            
            userImage.isHidden = true
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
}
