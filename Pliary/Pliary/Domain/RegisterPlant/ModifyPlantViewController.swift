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
    }
}
