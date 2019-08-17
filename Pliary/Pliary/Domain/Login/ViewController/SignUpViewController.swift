//
//  SignUpViewController.swift
//  Pliary
//
//  Created by jueun lee on 2019. 7. 23..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Firebase
import Hero

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userProfileView: UIView!
    let imagePickerController = UIImagePickerController()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailResetButton: UIButton!
    @IBOutlet weak var passwordResetButton: UIButton!
    @IBOutlet weak var passwordGuideLabel: UILabel!
    @IBOutlet weak var emailGuideLabel: UILabel!
    @IBOutlet weak var emailWarningAlert: UIImageView!
    @IBOutlet weak var passwordWarningAlert: UIImageView!
    @IBOutlet weak var emailSuccessAlert: UIImageView!
    @IBOutlet weak var passwordSuccessAlert: UIImageView!

    
    var keyboardHeight: CGFloat = 0
    let prifileImage : UIImage = #imageLiteral(resourceName: "defaultProfie")
    
    @IBAction func backButton(_ sender: Any) {
        hero.modalAnimationType = .pull(direction: .right)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func emailResetButtonClick(_ sender: UIButton) {
        emailTextField.text = ""
    }
    @IBAction func passwordResetButtonClick(_ sender: UIButton) {
        passwordTextField.text = ""
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        let velocity = gr.velocity(in: view)
        
        switch gr.state {
        case .began:
            hero.modalAnimationType = .pull(direction: .right)
            dismiss(animated: true, completion: nil)
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
    @objc func endEdit(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            if scrollView.frame.height > scrollView.contentSize.height {
                scrollView.contentSize.height = scrollView.frame.height + keyboardHeight / 2
            } else {
                scrollView.contentSize.height = contentView.frame.maxY + keyboardHeight / 2
            }
            
            scrollView.contentOffset.y = userProfileView.frame.maxY
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
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
        updateSignUpButtonState()
        scrollView.contentSize.height = contentView.frame.maxY
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        signUpButton.isEnabled = false
        if(textField.isEqual(emailTextField)) {
            emailResetButton.isHidden = false
        } else if(textField.isEqual(passwordTextField)) {
            passwordTextField.isHidden = false
        }
    }
    func showEmailAlert(reset : Bool, warning : Bool, succeess : Bool){
        emailResetButton.isHidden = reset
        emailWarningAlert.isHidden = warning
        emailSuccessAlert.isHidden = succeess
    }
    
    func showPasswordAlert(reset : Bool, warning : Bool, succeess : Bool){
        passwordResetButton.isHidden = reset
        passwordWarningAlert.isHidden = warning
        passwordSuccessAlert.isHidden = succeess
    }

    func updateSignUpButtonState() {
        let email : String = emailTextField.text ?? ""
        let password : String = passwordTextField.text ?? ""
        
        if !isValidEmailAddress(email: email) {
            showEmailAlert(reset: true, warning: false, succeess: true)
            emailGuideLabel.text = "이메일 형식에 맞지 않습니다."
            emailTextField.setBottomBorder(color: Color.gray7)
        } else if isExistsEmail(email: email) {
            showEmailAlert(reset: true, warning: false, succeess: true)
            emailGuideLabel.text = "이미 사용중인 이메일입니다."
            emailTextField.setBottomBorder(color: Color.gray7)
        } else {
            emailGuideLabel.text = ""
            showEmailAlert(reset: true, warning: true, succeess: false)
            emailTextField.setBottomBorder(color: Color.green)
        }
        
        if isValidPassword(password: password) {
            passwordGuideLabel.text = ""
            showPasswordAlert(reset: true, warning: true, succeess: false)
            passwordTextField.setBottomBorder(color: Color.green)
        } else {
            passwordGuideLabel.text = "대문자, 소문자, 숫자 조합 8글자 이상"
            showPasswordAlert(reset: true, warning: false, succeess: true)
            passwordTextField.setBottomBorder(color: Color.gray7)
        }
        
        if isValidEmailAddress(email: email) && isValidPassword(password: password) {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = Color.green
            
            signUpButton.layer.applySketchShadow(color: Color.buttonShadow, alpha: 0.4, x: 0, y: 10, blur: 14, spread: 0)
            signUpButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            signUpButton.isEnabled = false
            signUpButton.setTitleColor(Color.gray5, for: .normal)
            signUpButton.backgroundColor = Color.gray7
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
    
    func ProfileImageViewLoad(){
        let userProfile = UserProfileView.instance()
        userProfile.delegate = self
        userProfile.frame = CGRect(x: 0, y: 0, width: userProfileView.bounds.width, height: userProfileView.bounds.height)
        userProfileView.addSubview(userProfile);
    }
    
}

extension SignUpViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileImageViewLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.setBottomBorder(color: Color.gray7)
        passwordTextField.setBottomBorder(color: Color.gray7)
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 620)
        if let user = Auth.auth().currentUser {
            // 이미 login 상태
            return
        }
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
}

extension SignUpViewController: LoginEventDelegate {
    func loginEvent() {
        selectImageFromPhotoLibrary()
    }
}
