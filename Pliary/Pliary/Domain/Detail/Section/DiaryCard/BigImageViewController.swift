//
//  BigImageViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 12/10/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class BigImageViewController: UIViewController {

    @IBOutlet weak var diaryImageView: UIImageView!
    @IBAction func tapCloseButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
}

extension BigImageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
