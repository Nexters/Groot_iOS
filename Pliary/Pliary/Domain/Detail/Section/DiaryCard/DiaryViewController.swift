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
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    var currentMode: DiaryViewMode = .writeNewDiary
    var currentDiaryCard: DiaryCard?
    var keyboardHeight: CGFloat = 0
    
    @IBAction func tapAddOrSubtractButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.navigationBar.tintColor = .black
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func tapRightNavigationButton(_ sender: Any) {
        switch currentMode {
        case .writeNewDiary:
            changeMode(.showDiary)
        case .editDiary:
            changeMode(.showDiary)
        case .showDiary:
            showModifyDeleteAlert()
        }
    }
    
    private func changeMode(_ mode: DiaryViewMode) {
        currentMode = mode
        switch mode {
        case .writeNewDiary:
            navigationRightButton.setImage(Image.completeButton, for: .normal)
            diaryTextView.isSelectable = true
            diaryTextView.isEditable = true
            addOrSubtractContentView.isHidden = false
        case .editDiary:
            navigationRightButton.setImage(Image.completeButton, for: .normal)
            diaryTextView.isSelectable = true
            diaryTextView.isEditable = true
            addOrSubtractContentView.isHidden = false
        case .showDiary:
            navigationRightButton.setImage(Image.moreButton, for: .normal)
            diaryTextView.isSelectable = false
            diaryTextView.isEditable = false
            addOrSubtractContentView.isHidden = true
            diaryImageView.image = currentDiaryCard?.diaryImage
            diaryDateLabel.text = currentDiaryCard?.timeStamp
        }
    }
    
    private func showModifyDeleteAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modifyAction = UIAlertAction(title: "수정", style: .default, handler: { _ in
            self.changeMode(.editDiary)
        })
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler : nil )
        
        alert.addAction(modifyAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.view.tintColor = .black
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        let velocity = gr.velocity(in: view)
        
        switch gr.state {
        case .began:
            hero.modalAnimationType = .pull(direction: .right)
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.x / view.bounds.width)
        default:
            if ((translation.x + velocity.x) / view.bounds.width) > 0.65 {
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
            addOrSubtractContentView.backgroundColor = Color.gray6
            addOrSubtractImageView.image = Image.plusButton
        } else {
            addOrSubtractContentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            diaryImageView.image = currentDiaryCard?.diaryImage
            addOrSubtractContentView.isHidden = true
            addOrSubtractImageView.image = Image.minusButton
        }
    }
    
    private func setTextView() {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let atributes = [NSAttributedString.Key.paragraphStyle: style ]
        diaryTextView.attributedText = NSAttributedString(string: diaryTextView.text, attributes: atributes)
        diaryTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        diaryTextView.textColor = Color.gray3
        
        textViewHeightConstraint.constant = diaryTextView.contentSize.height + 10
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        
        diaryTextView.delegate = self
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            if scrollView.frame.height > scrollView.contentSize.height {
                scrollView.contentSize.height = scrollView.frame.height + keyboardHeight
            } else {
                scrollView.contentSize.height = diaryTextView.frame.maxY + textViewBottomConstraint.constant + keyboardHeight
            }
            
            self.scrollView.contentOffset.y = self.diaryDateLabel.frame.maxY
            
//            DispatchQueue.main.async {
//                if let selectedRange = self.diaryTextView.selectedTextRange {
//                    let cursorPosition = self.diaryTextView.offset(from: self.diaryTextView.beginningOfDocument, to: selectedRange.start)
//
//                    self.scrollView.contentOffset.y = self.diaryImageView.frame.maxY + CGFloat(cursorPosition)
//                }
//            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentSize.height = diaryTextView.frame.maxY + textViewBottomConstraint.constant
    }
    
    @objc func endEdit(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension DiaryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        view.addGestureRecognizer(gesture)
        
        reload()
        changeMode(currentMode)
        setTextView()
        
        // check
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
}

extension DiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        currentDiaryCard?.diaryImage = selectedImage
        reload()
        changeMode(.editDiary)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension DiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textViewHeightConstraint.constant = diaryTextView.contentSize.height + 10
    }
}
