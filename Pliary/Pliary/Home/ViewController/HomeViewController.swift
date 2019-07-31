//
//  HomeViewController.swift
//  
//
//  Created by jueun lee on 2019. 7. 31..
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var customNameLabel: UILabel!
    @IBOutlet weak var slideBackgroundView: UIView!
    @IBOutlet weak var selectedSlideView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func tabProfileImageButton(_ sender: Any) {
        
    }
    
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

