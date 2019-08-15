//
//  ChangeUserInfoViewController.swift
//  Pliary
//
//  Created by jueun lee on 2019. 8. 9..
//  Copyright © 2019년 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero

class ChangeUserInfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentPWTextField: UITextField!
    @IBOutlet weak var newPWTextField: UITextField!
    @IBOutlet weak var checkPWTextField: UITextField!

    @IBOutlet weak var currentPWSuccessAlert: UIImageView!
    @IBOutlet weak var newPWSuccessAlert: UIImageView!
    @IBOutlet weak var checkPWSuccessAlert: UIImageView!
    
    @IBOutlet weak var changePWButton: UIButton!
    
    @IBAction func tapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        let velocity = gr.velocity(in: view)
        
        switch gr.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.x / view.bounds.width)
        default:
            if ((translation.x + velocity.x) / view.bounds.width) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentPWTextField.delegate = self
        newPWTextField.delegate = self
        checkPWTextField.delegate = self
        
        currentPWTextField.setBottomBorder(color: UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0))
        newPWTextField.setBottomBorder(color: UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0))
        checkPWTextField.setBottomBorder(color: UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0))
        // Do any additional setup after loading the view.
        
        changePWButton.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField.isEqual(currentPWTextField)) {
            newPWTextField.becomeFirstResponder()
        } else if(textField.isEqual(newPWTextField)) {
            checkPWTextField.becomeFirstResponder()
        } else if(textField.isEqual(checkPWTextField)) {
            checkPWTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateChangeButtonState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changePWButton.isEnabled = false
    }
    
    func updateChangeButtonState() {
        let currentPW : String = self.currentPWTextField.text ?? ""
        let newPW : String = self.newPWTextField.text ?? ""
        let checkPW : String = self.checkPWTextField.text ?? ""
    
        // [TODO] currentPW check
        let isCurrentPW : Bool = true
        if isCurrentPW {
            currentPWSuccessAlert.isHidden = false
        } else {
            currentPWSuccessAlert.isHidden = true
        }
        
        let isValidPW : Bool = isValidPassword(password: newPW)
        if isValidPW {
            newPWSuccessAlert.isHidden = false
        } else {
            newPWSuccessAlert.isHidden = true
        }
        
        let isEqualPW :Bool = newPW != "" && newPW.elementsEqual(checkPW)
        if isEqualPW {
            checkPWSuccessAlert.isHidden = false
        } else {
            checkPWSuccessAlert.isHidden = true
        }
        
        if isCurrentPW && isValidPW && isEqualPW {
            changePWButton.isEnabled = true
            changePWButton.backgroundColor = UIColor(red: 106.0/255.0, green: 167.0/255.0, blue: 111.0/255.0, alpha: 1.0)
            
            changePWButton.layer.applySketchShadow(color: UIColor(red: 105.0/255.0, green: 146.0/255.0, blue: 117.0/255.0, alpha: 0.4), alpha: 0.4, x: 0, y: 10, blur: 14, spread: 0)
            changePWButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            changePWButton.isEnabled = false
            changePWButton.setTitleColor(UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1.0), for: .normal)
            changePWButton.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            changePWButton.layer.applySketchShadow(color: UIColor.white, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
        
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "\\A(?=[^A-Z]*[A-Z])(?=[^a-z]*[a-z])(?=\\D*\\d)\\S{8,}\\z"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }

    
    @IBAction func changePWButtonTouched(_ sender: Any) {
        guard let password = newPWTextField.text else { return }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
