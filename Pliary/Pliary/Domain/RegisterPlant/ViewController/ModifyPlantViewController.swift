//
//  ModifyPlantViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class ModifyPlantViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    @IBAction func tabCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapCompleteButton(_ sender: Any) {
        
    }
    
}

extension ModifyPlantViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        completeButton.clipsToBounds = true
        completeButton.layer.cornerRadius = 6
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let numberNib = UINib(nibName: NumberCollectionViewCell.identifier, bundle: nil)
        collectionView.register(numberNib, forCellWithReuseIdentifier: NumberCollectionViewCell.identifier)
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
}

extension ModifyPlantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCollectionViewCell.identifier, for: indexPath) as? NumberCollectionViewCell {
            cell.numberLabel.text = (indexPath.item + 1).description
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
