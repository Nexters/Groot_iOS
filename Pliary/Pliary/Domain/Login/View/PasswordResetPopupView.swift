//
//  passwordResetPopupView.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 4..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class PasswordResetPopupView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailSuccessAlert: UIImageView!
    @IBOutlet weak var  emailWarningAlert: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emailResetButton: UIButton!
    @IBOutlet weak var emailGuideLabel: UILabel!
    
    class func instance() -> UIView {
        let view: PasswordResetPopupView = UIView.createViewFromNib(nibName: PasswordResetPopupView.identifier)
        return view
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emailTextField.delegate = self
        emailTextField.setBottomBorder(color: Color.gray7)
    }
    
    @IBAction func summitButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func PopupViewCloseButtonClick(_ sender: UIButton) {
        removeFromSuperview()
    }
    
    @IBAction func textResetButtonClicked(_ sender: Any) {
        emailTextField.text = ""
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let email = emailTextField.text else { return true }
        updateState(isValid: isValidEmailAddress(email: email))
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        submitButton.isEnabled = false
        emailResetButton.isHidden = false
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let email = emailTextField.text else { return }
        updateState(isValid: isValidEmailAddress(email: email))
        
    }
    
    func showEmailAlert(reset : Bool, warning : Bool, succeess : Bool){
        emailResetButton.isHidden = reset
        emailWarningAlert.isHidden = warning
        emailSuccessAlert.isHidden = succeess
    }
    
    func updateState(isValid : Bool) {
        if isValid {
            showEmailAlert(reset: false, warning: false, succeess: true)
            emailGuideLabel.text = ""
            submitButton.isEnabled = true
            submitButton.backgroundColor = Color.green
            submitButton.layer.applySketchShadow(color: Color.buttonShadow, alpha: 0.4, x: 0, y: 10, blur: 14, spread: 0)
            submitButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            showEmailAlert(reset: true, warning: false, succeess: true)
            emailGuideLabel.frame.size = CGSize(width: 303, height: 16)
            emailGuideLabel.text = "이메일 형식에 맞지 않습니다."
            submitButton.isEnabled = false
            submitButton.setTitleColor(Color.gray5, for: .normal)
            submitButton.backgroundColor = Color.gray7
            submitButton.layer.applySketchShadow(color: UIColor.white, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
    }
    
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return predicate.evaluate(with: email)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    
}
