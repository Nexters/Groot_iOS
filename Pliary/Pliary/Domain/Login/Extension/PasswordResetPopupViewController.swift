//
//  PasswordResetPopupViewController+UITextFieldDelegate.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 4..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit

class PasswordResetPopupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var warningAlertImage: UIImageView!
    @IBOutlet weak var successAlertImage: UIImageView!
    @IBOutlet weak var emailGuideLabel: UILabel!
    @IBOutlet weak var emailResetButton: UIButton!
    @IBOutlet weak var sendNewPasswordButton: UIButton!
    @IBAction func emailResetButtonClick(_ sender: UIButton) {
        emailTextField.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        emailGuideLabel.frame.size = CGSize(width: 0, height: 0)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButtonState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        sendNewPasswordButton.isEnabled = false
        emailResetButton.isHidden = false
    }
    
    func updateLoginButtonState() {
        let email : String = emailTextField.text ?? ""
        
        if !isValidEmailAddress(email: email) {
            emailResetButton.isHidden = true
            warningAlertImage.isHidden = false
            successAlertImage.isHidden = true
            //            emailGuideLabel.isHidden = false
            emailGuideLabel.text = "이메일 형식에 맞지 않습니다."
            emailGuideLabel.frame.size = CGSize(width: 303, height: 16)
        } else {
            emailGuideLabel.text = ""
            emailGuideLabel.frame.size = CGSize(width: 0, height: 0)
            //            emailGuideLabel.isHidden = true
            emailResetButton.isHidden = true
            warningAlertImage.isHidden = true
            successAlertImage.isHidden = false
        }
        
        if isValidEmailAddress(email: email) {
            emailResetButton.isEnabled = true
            emailResetButton.backgroundColor = UIColor(red: 106.0/255.0, green: 167.0/255.0, blue: 111.0/255.0, alpha: 1.0)
            
            emailResetButton.layer.applySketchShadow(color: UIColor(red: 105.0/255.0, green: 146.0/255.0, blue: 117.0/255.0, alpha: 0.4), alpha: 0.4, x: 0, y: 10, blur: 14, spread: 0)
            emailResetButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            emailResetButton.isEnabled = false
            emailResetButton.setTitleColor(UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1.0), for: .normal)
            emailResetButton.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            emailResetButton.layer.applySketchShadow(color: UIColor.white, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
            
        }

    }
    
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return predicate.evaluate(with: email)
    }

}
