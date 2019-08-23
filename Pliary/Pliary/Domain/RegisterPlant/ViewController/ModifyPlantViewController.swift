//
//  ModifyPlantViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import UserNotifications

class ModifyPlantViewController: UIViewController {
    
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var textFieldBottomLineView: UIView!

    private var gradient: CAGradientLayer?
    private var currentInterval: Int = Global.shared.selectedPlant?.wateringInterval ?? 1
    
    @IBAction func tabCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapCompleteButton(_ sender: Any) {
        if let nickName = nicknameTextField.text, nickName.count <= 5, nickName.count > 0 {
            Global.shared.selectedPlant?.nickName = nickName
            Global.shared.selectedPlant?.wateringInterval = currentInterval
            
            var plants: [Plant] = []
            for plant in Global.shared.plants {
                if let selectedPlant = Global.shared.selectedPlant, plant.id == selectedPlant.id {
                    plants.append(selectedPlant)
                } else {
                    plants.append(plant)
                }
            }
            Global.shared.plants = plants
            
            UserNotification.watering.registerNotification()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func setGradientScript() {
        gradient = CAGradientLayer()
        gradient?.startPoint = CGPoint(x: 0, y: 0.5)
        gradient?.endPoint = CGPoint(x:1.0, y:0.5)
        gradient?.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient?.locations = [0, 0.45, 0.55, 1]
        gradient?.frame = maskView.bounds
        maskView.layer.mask = gradient
    }
}

extension ModifyPlantViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        completeButton.clipsToBounds = true
        completeButton.layer.cornerRadius = 6
        
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let numberNib = UINib(nibName: NumberCollectionViewCell.identifier, bundle: nil)
        collectionView.register(numberNib, forCellWithReuseIdentifier: NumberCollectionViewCell.identifier)
        
        nicknameTextField.text = Global.shared.selectedPlant?.nickName
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setGradientScript()
        let width = collectionView.frame.width / 5
        collectionView.contentOffset.x = CGFloat(currentInterval - 1) * width
    }
}

extension ModifyPlantViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemCellSize: CGSize = CGSize(width: collectionView.frame.width / 5, height: 30)
        let pageWidth = (itemCellSize.width)
        let itemIndex = (targetContentOffset.pointee.x) / pageWidth
        targetContentOffset.pointee.x = round(itemIndex) * pageWidth
        
        currentInterval = Int(round(itemIndex) + 1)
    }
}

extension ModifyPlantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCollectionViewCell.identifier, for: indexPath) as? NumberCollectionViewCell {
            if indexPath.item == 0 || indexPath.item == 1 || indexPath.item == 62 || indexPath.item == 63 {
                cell.numberLabel.isHidden = true
            } else {
                cell.numberLabel.isHidden = false
                cell.numberLabel.text = (indexPath.item - 1).description
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

extension ModifyPlantViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let textCount = textField.text?.count else {
            helpLabel.textColor = Color.pink
            
            return
        }
        if textCount > 0 && textCount < 6 {
            helpLabel.textColor = Color.gray4
            completeButton.isEnabled = true
            completeButton.backgroundColor = Color.green
            completeButton.setTitleColor(.white, for: .normal)
        } else {
            helpLabel.textColor = Color.pink
            completeButton.isEnabled = false
            completeButton.backgroundColor = Color.gray7
            completeButton.setTitleColor(Color.gray5, for: .normal)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldBottomLineView.backgroundColor = Color.green
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldBottomLineView.backgroundColor = Color.gray7
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
