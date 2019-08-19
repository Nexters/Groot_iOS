//
//  PasswordResetPopupViewController+UITextFieldDelegate.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 4..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class FindPasswordViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var warningAlertImage: UIImageView!
    @IBOutlet weak var successAlertImage: UIImageView!
    @IBOutlet weak var emailGuideLabel: UILabel!
    @IBOutlet weak var emailResetButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func emailResetButtonClick(_ sender: UIButton) {
        emailTextField.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        emailTextField.setBottomBorder(color: Color.gray7)
  
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
        warningAlertImage.isHidden = warning
        successAlertImage.isHidden = succeess
    }
    
    func updateState(isValid : Bool) {
        if isValid {
            showEmailAlert(reset: true, warning: true, succeess: false)
            emailGuideLabel.text = ""
            submitButton.isEnabled = true
            submitButton.backgroundColor = Color.green
            submitButton.setTitleColor(UIColor.white, for: .normal)
            submitButton.layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)
        } else {
            showEmailAlert(reset: true, warning: false, succeess: true)
            emailGuideLabel.text = "이메일 형식에 맞지 않습니다."
            submitButton.isEnabled = false
            submitButton.setTitleColor(Color.gray5, for: .normal)
            submitButton.backgroundColor = Color.gray7
        }
    }
    

    @IBAction func sendButtonClicked(_ sender: Any) {
        
        // email send
        completePopupLoad()
    }
    func completePopupLoad() {
        let popup = BasicPopupView.instance()
        popup.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        popup.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        
        self.view.addSubview(popup);
    }
    
    @IBAction func PopupViewCloseButtonClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return predicate.evaluate(with: email)
    }
    
}
