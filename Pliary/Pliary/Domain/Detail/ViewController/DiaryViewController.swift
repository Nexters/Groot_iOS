//
//  DiaryViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 08/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero

enum DiaryViewMode {
    case showDiary
    case editDiary
    case writeNewDiary
}

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var addOrSubtractImageView: UIImageView!
    @IBOutlet weak var addOrSubtractContentView: UIView!
    @IBOutlet weak var diaryImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var diaryDateLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var diaryTextView: UITextView!
    
    @IBOutlet weak var navigationRightButton: UIButton!
    
    
    var currentMode: DiaryViewMode = .writeNewDiary {
        didSet {
            switch currentMode {
            case .writeNewDiary:
                ()
            case .editDiary:
                ()
            case .showDiary:
                addOrSubtractContentView.isHidden = true
                diaryImageView.image = currentDiaryCard?.diaryImage
                diaryDateLabel.text = currentDiaryCard?.timeStamp
            }
        }
    }
    
    var currentDiaryCard: DiaryCard? {
        didSet {
            reload()
        }
    }
    
    @IBAction func tapAddOrSubtractButton(_ sender: Any) {
        
    }
    
    @IBAction func tapRightNavigationButton(_ sender: Any) {
        
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
        diaryDateLabel.text = currentDiaryCard?.timeStamp
        
        if currentDiaryCard?.diaryText == nil {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
            diaryTextView.text = currentDiaryCard?.diaryText
        }
        
        if currentDiaryCard?.diaryImage == nil {
            addOrSubtractContentView.isHidden = false
            diaryImageView.image = nil
        } else {
            addOrSubtractContentView.isHidden = true
            diaryImageView.image = currentDiaryCard?.diaryImage
        }
    }
}

extension DiaryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        view.addGestureRecognizer(gesture)
        
        scrollView.contentSize.height = 100000
    }
}
