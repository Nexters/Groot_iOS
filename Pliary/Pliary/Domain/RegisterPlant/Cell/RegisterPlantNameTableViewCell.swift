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
    weak var delegate: RegisterEventDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldBottomLineView: UIView!
    @IBOutlet weak var helpTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    func setUp(with plant: Plant, type: RegisterRowType) {
        if (type != self.type) || (plant != self.plant) {
            nameTextField.text = nil
            helpTextLabel.textColor = Color.gray4
        }
        
        self.plant = plant
        self.type = type
        
        handleType(type)
    }
    
    func handleType(_ type: RegisterRowType) {
        switch type {
        case .englishName:
            nameTextField.keyboardType = .alphabet
            titleLabel.text = "영어명 (필수, 수정불가)"
            nameTextField.placeholder = "ex. Stuki"
            nameTextField.text = plant?.englishName
            helpTextLabel.text = "영어 최대 15글자까지 입력 가능합니다."
            checkEnglishName(nameTextField.text ?? "")
        case .koreanName:
            nameTextField.keyboardType = .default
            titleLabel.text = "한글명 (선택)"
            nameTextField.text = plant?.koreanName
            nameTextField.placeholder = "ex. 스투키"
            helpTextLabel.text = "한글 최대 10글자까지 입력 가능합니다."
            checkKoreanName(nameTextField.text ?? "")
        case .customName:
            nameTextField.keyboardType = .default
            titleLabel.text = "식물 애칭"
            nameTextField.placeholder = "ex. 멋쟁이투투"
            nameTextField.text = plant?.nickName
            helpTextLabel.text = "애칭은 영어, 한글 최대 5글자까지 가능합니다."
            checkCustomName(nameTextField.text ?? "")
        default:
            ()
        }
    }
    
    func checkEnglishName(_ name: String) {
        // add check logic
        guard let textCount = nameTextField.text?.count else {
            delegate?.registerEvent(event: .setEnglishName(name: name, enable: false))
            helpTextLabel.textColor = Color.pink
            return
        }
        
        if textCount > 0 && textCount < 16 {
            delegate?.registerEvent(event: .setEnglishName(name: name, enable: true))
            helpTextLabel.textColor = Color.gray4
        } else {
            delegate?.registerEvent(event: .setEnglishName(name: name, enable: false))
            helpTextLabel.textColor = Color.pink
        }
    }
    
    func checkKoreanName(_ name: String) {
        // add check logic
        guard let textCount = nameTextField.text?.count else {
            delegate?.registerEvent(event: .setKoreanName(name: name, enable: false))
            helpTextLabel.textColor = Color.pink
            return
        }
        
        if textCount > 0 && textCount < 11 {
            delegate?.registerEvent(event: .setKoreanName(name: name, enable: true))
            helpTextLabel.textColor = Color.gray4
        } else {
            delegate?.registerEvent(event: .setKoreanName(name: name, enable: false))
            helpTextLabel.textColor = Color.pink
        }
    }
    
    func checkCustomName(_ name: String) {
        // add check logic
        guard let textCount = nameTextField.text?.count else {
            delegate?.registerEvent(event: .setNickName(name: name, enable: false))
            helpTextLabel.textColor = Color.pink
            return
        }
        
        if textCount > 0 && textCount < 6 {
            delegate?.registerEvent(event: .setNickName(name: name, enable: true))
            helpTextLabel.textColor = Color.gray4
        } else {
            delegate?.registerEvent(event: .setNickName(name: name, enable: false))
            helpTextLabel.textColor = Color.pink
        }
    }
    
}
extension RegisterPlantNameTableViewCell: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let type = self.type else { return }
        
        switch type {
        case .englishName:
            checkEnglishName(textField.text ?? "")
        case .koreanName:
            checkKoreanName(textField.text ?? "")
        case .customName:
            checkCustomName(textField.text ?? "")
        default:
            ()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldBottomLineView.backgroundColor = Color.green
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldBottomLineView.backgroundColor = Color.gray7
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }

}
