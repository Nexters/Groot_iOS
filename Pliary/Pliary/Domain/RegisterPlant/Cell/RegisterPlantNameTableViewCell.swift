//
//  RegisterPlantNameTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class RegisterPlantNameTableViewCell: UITableViewCell, RegisterCell {
    
    var type: RegisterRowType?
    var plant: Plant?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldBottomLineView: UIView!
    @IBOutlet weak var helpTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.delegate = self
    }
    
    func setUp(with plant: Plant, type: RegisterRowType) {
        if (type != self.type) || (plant != self.plant) {
            nameTextField.text = nil
        }
        
        self.plant = plant
        self.type = type
        
        handleType(type)
    }
    
    func handleType(_ type: RegisterRowType) {
        switch type {
        case .englishName:
            nameTextField.keyboardType = .asciiCapable
            titleLabel.text = "영어명 (필수, 수정불가)"
            nameTextField.placeholder = "ex. Stuki"
            helpTextLabel.text = "영어 최대 15글자까지 입력 가능합니다."
        case .koreanName:
            titleLabel.text = "한글명 (선택)"
            nameTextField.placeholder = "ex. 스투키"
            helpTextLabel.text = "한글 최대 10글자까지 입력 가능합니다."
        case .customName:
            titleLabel.text = "식물 애칭"
            nameTextField.placeholder = "ex. 멋쟁이투투"
            helpTextLabel.text = "애칭은 영어, 한글 최대 5글자까지 가능합니다."
        default:
            ()
        }
    }
}
extension RegisterPlantNameTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let type : RegisterRowType = self.type!
        switch type {
        case .englishName:
            return updatedText.count < 16
        case .koreanName:
            return updatedText.count < 11
        case .customName:
            return updatedText.count < 6
        default:
            return updatedText.count < 11
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldBottomLineView.backgroundColor = Color.green
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }

}
