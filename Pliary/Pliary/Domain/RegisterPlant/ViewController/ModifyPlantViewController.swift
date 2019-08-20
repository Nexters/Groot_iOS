//
//  ModifyPlantViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class ModifyPlantViewController: UIViewController {
    
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var textFieldBottomLineView: UIView!

    
    private var gradient: CAGradientLayer?
    var plant: Plant?
    
    @IBAction func tabCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapCompleteButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let numberNib = UINib(nibName: NumberCollectionViewCell.identifier, bundle: nil)
        collectionView.register(numberNib, forCellWithReuseIdentifier: NumberCollectionViewCell.identifier)
        
        nicknameTextField.text = plant?.nickName
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradientScript()
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count < 6
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldBottomLineView.backgroundColor = Color.green
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
