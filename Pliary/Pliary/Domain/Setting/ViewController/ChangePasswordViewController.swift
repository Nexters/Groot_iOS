//
//  ChangeUserInfoViewController.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 9..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero
import Firebase

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var currentPWLabel: UILabel!
    @IBOutlet weak var currentPWTextField: UITextField!
    @IBOutlet weak var newPWTextField: UITextField!
    @IBOutlet weak var checkPWTextField: UITextField!
    
    @IBOutlet weak var currentPWSuccessAlert: UIImageView!
    @IBOutlet weak var newPWSuccessAlert: UIImageView!
    @IBOutlet weak var checkPWSuccessAlert: UIImageView!
    
    @IBOutlet weak var newPWWarningAlert: UIImageView!
    @IBOutlet weak var checkPWWarningAlert: UIImageView!
    
    @IBOutlet weak var changePWButton: UIButton!
    
    
    @IBOutlet weak var newPWGuideLabel: UILabel!
    @IBOutlet weak var checkPWGuideLabel: UILabel!
    
    var keyboardHeight: CGFloat = 0
    
    var isValidPW : Bool = false
    var isEqualPW : Bool = false
    var isNil : Bool = false
    
    @IBAction func tapBackButton(_ sender: Any) {
        hero.modalAnimationType = .pull(direction: .right)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changePWButtonTouched(_ sender: Any) {
        guard let password = currentPWTextField.text else { return }
        guard let newPassword = newPWTextField.text else { return }
        
        if let email = Auth.auth().currentUser?.email {
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                guard let error = AuthErrorCode(rawValue: (error?._code)!) else {
                    // Successfully login!
                    Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
                        self.completePopupLoad()
                        return
                    }
                    return
                }
                // Error!
                let manager :FirebaseAuthenticationManager = FirebaseAuthenticationManager.shared
                manager.firebaseErrorHandle(code: error)
                self.wrongPWPopupLoad()
            }
        }
    }
    
    func wrongPWPopupLoad() {
        let popup = BasicPopupView.instance()
        
        popup.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        popup.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        popup.setUp(with: "비밀번호를 잘못 입력하셨습니다.")
        self.view.addSubview(popup);
    }
    
    func completePopupLoad() {
        let popup = BasicPopupView.instance()
        
        popup.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        popup.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        popup.setUp(with: "비밀번호가 정상적으로\n변경되었습니다.")
        self.view.addSubview(popup);
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let text = textField.text ?? ""
        if(textField.isEqual(currentPWTextField)) {
            isNil = checkNil(text)
            newPWTextField.becomeFirstResponder()
        } else if(textField.isEqual(newPWTextField)) {
            isValidPW = newPW(text)
            checkPWTextField.becomeFirstResponder()
        } else if(textField.isEqual(checkPWTextField)) {
            isEqualPW = checkPW(text)
            checkPWTextField.resignFirstResponder()
            updateChangeButtonState(isEnable: isNil && isValidPW && isEqualPW)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changePWButton.isEnabled = false
    }
    
    func updateChangeButtonState(isEnable : Bool) {
        
        if isEnable {
            changePWButton.isEnabled = true
            changePWButton.setTitleColor(UIColor.white, for: .normal)
            changePWButton.backgroundColor = Color.green
            changePWButton.layer.applySketchShadow(color: UIColor(red: 105.0/255.0, green: 146.0/255.0, blue: 117.0/255.0, alpha: 0.4), alpha: 0.4, x: 0, y: 10, blur: 14, spread: 0)
            changePWButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            changePWButton.isEnabled = false
            changePWButton.setTitleColor(Color.gray5, for: .normal)
            changePWButton.backgroundColor = Color.gray7
            changePWButton.layer.applySketchShadow(color: UIColor.white, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "\\A(?=[^A-Z]*[A-Z])(?=[^a-z]*[a-z])(?=\\D*\\d)\\S{8,}\\z"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let text = textField.text ?? ""
        textField.resignFirstResponder()
        if(textField.isEqual(currentPWTextField)) {
            isNil = checkNil(text)
            newPWTextField.becomeFirstResponder()
        } else if(textField.isEqual(newPWTextField)) {
            isValidPW = newPW(text)
            checkPWTextField.becomeFirstResponder()
        } else if(textField.isEqual(checkPWTextField)) {
            isEqualPW = checkPW(text)
            checkPWTextField.resignFirstResponder()
            updateChangeButtonState(isEnable: isNil && isValidPW && isEqualPW)
        }
        
        return true
    }
    
    func checkNil(_ text : String) -> Bool {
        let isNil = text != ""
        if isNil {
            self.currentPWSuccessAlert.isHidden = false
        } else {
            self.currentPWSuccessAlert.isHidden = true
        }
        return isNil
    }
    
    func newPW(_ text : String) -> Bool {
        isValidPW = isValidPassword(password: text)
        if isValidPW {
            newPWGuideLabel.text = ""
            newPWSuccessAlert.isHidden = false
            newPWWarningAlert.isHidden = true
        } else {
            newPWGuideLabel.text = "대문자, 소문자, 숫자 조합 8글자 이상"
            newPWSuccessAlert.isHidden = true
            newPWWarningAlert.isHidden = false
        }
        return isValidPW
    }
    
    func checkPW(_ text : String) -> Bool {
        let newPW = newPWTextField.text ?? ""
        isEqualPW = text != "" && newPW.elementsEqual(text)
        if isEqualPW {
            checkPWGuideLabel.text = ""
            checkPWSuccessAlert.isHidden = false
            checkPWWarningAlert.isHidden = true
        } else {
            checkPWGuideLabel.text = "비밀번호 재확인"
            checkPWSuccessAlert.isHidden = true
            checkPWWarningAlert.isHidden = false
        }
        return isEqualPW
    }


}
extension ChangePasswordViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPWTextField.delegate = self
        newPWTextField.delegate = self
        checkPWTextField.delegate = self
        
        currentPWTextField.setBottomBorder(color: Color.gray7)
        newPWTextField.setBottomBorder(color: Color.gray7)
        checkPWTextField.setBottomBorder(color: Color.gray7)
        // Do any additional setup after loading the view.
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 400)
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        view.addGestureRecognizer(gesture)
        
        changePWButton.isEnabled = false
    }
    
    @objc func endEdit(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            if scrollView.frame.height > scrollView.contentSize.height {
                scrollView.contentSize.height = scrollView.frame.height + keyboardHeight
            } else {
                scrollView.contentSize.height = contentView.frame.maxY + keyboardHeight
            }
            scrollView.contentOffset.y = currentPWLabel.frame.minY
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
