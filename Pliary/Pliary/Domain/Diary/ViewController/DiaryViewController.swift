//
//  DiaryViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 08/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var navigationRightButton: UIButton!
    
    var currentDiaryCard: DiaryCard? {
        didSet {
            reload()
        }
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
    
    private func reload() {
        
    }
}

extension DiaryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        view.addGestureRecognizer(gesture)
    }
}
