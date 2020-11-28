//
//  DiaryViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 08/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero
import Photos
import Kingfisher

enum DiaryViewMode {
    case showDiary
    case editDiary
    case writeNewDiary
}

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var bigImageButton: UIButton!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var addOrSubtractImageView: UIImageView!
    @IBOutlet weak var addOrSubtractContentView: UIView!
    @IBOutlet weak var diaryImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var diaryDateLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var diaryTextView: UITextView!
    @IBOutlet weak var navigationRightButton: UIButton!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var diaryImageHeightConstraint: NSLayoutConstraint!
    
    var currentMode: DiaryViewMode = .writeNewDiary
    var currentDiaryCard: DiaryCard?
    var selectedImage: PHAsset?
    
    @IBAction func tapBackButton(_ sender: Any) {
        Hero.shared.cancel()
        hero.modalAnimationType = .pull(direction: .right)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapBigImageButton(_ sender: Any) {
        switch currentMode {
        case .showDiary:
            let storyboard = UIStoryboard.init(name: StoryboardName.detail, bundle: nil)
            
            guard let bigImageVC = storyboard.instantiateViewController(withIdentifier: BigImageViewController.identifier) as? BigImageViewController else {
                return
            }
            
            bigImageVC.modalPresentationStyle = .fullScreen
            bigImageVC.modalTransitionStyle = .crossDissolve
            present(bigImageVC, animated: false, completion: nil)
            bigImageVC.diaryImageView.image = diaryImageView.image
        default:
            break
        }
    }
    
    @IBAction func tapAddOrSubtractButton(_ sender: Any) {
        if diaryImageView.image == nil {
            let storyboard = UIStoryboard.init(name: StoryboardName.selectPhoto, bundle: nil)
            guard let photoVC = storyboard.instantiateViewController(withIdentifier: SelectPhotoViewController.identifier) as? SelectPhotoViewController else {
                return
            }
            photoVC.delegate = self
            present(photoVC, animated: true, completion: nil)
        } else {
            let image = UIImage(named: ImageName.plusButton)
            diaryImageView.image = nil
            selectedImage = nil
            addOrSubtractContentView.backgroundColor = Color.gray6
            addOrSubtractImageView.image = image
        }
    }
    
    @IBAction func tapRightNavigationButton(_ sender: Any) {
        switch currentMode {
        case .writeNewDiary:
            if diaryTextView.text == "" && diaryImageView.image == nil {
                showEmptyCardAlert()
                return
            }
            let card = DiaryCard(timeStamp: Date().timeIntervalSince1970, diaryText: diaryTextView.text, imageURL: getCurrentImageURL())
            currentDiaryCard = card
            changeMode(.showDiary)
            saveCurrentCard()
        case .editDiary:
            if diaryTextView.text == "" && diaryImageView.image == nil {
                showEmptyCardAlert()
                return
            }
            let url = getCurrentImageURL()
            currentDiaryCard?.imageURL = url
            currentDiaryCard?.diaryText = diaryTextView.text
            changeMode(.showDiary)
            editCard()
        case .showDiary:
            showModifyDeleteAlert()
        }
    }
    
    private func showEmptyCardAlert() {
        let alert = UIAlertController(title: "카드의 내용을 채워주세요!", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        alert.view.tintColor = Color.gray1
        
        present(alert, animated: true, completion: nil)
    }
    
    private func getCurrentImageURL() -> String? {
        if let image = diaryImageView.image {
            var imageURL: String? = currentDiaryCard?.imageURL
            if let identifier = selectedImage?.localIdentifier {
                let path = AssetManager.save(image: image, identifier: identifier)?.absoluteString
                if let last = path?.split(separator: "/").last {
                    imageURL = String(last)
                } else {
                    return nil
                }
            }
            return imageURL
        } else {
            return nil
        }
    }
    
    private func saveCurrentCard() {
        if let id = Global.shared.selectedPlant?.id, let card = currentDiaryCard {
            if var array = Global.shared.diaryDict[id] {
                array.insert(card, at: 0)
                Global.shared.diaryDict[id] = array
            } else {
                Global.shared.diaryDict[id] = [card]
            }
        }
    }
    
    private func editCard() {
        if let id = Global.shared.selectedPlant?.id, let currentCard = currentDiaryCard {
            let array = Global.shared.diaryDict[id] ?? []
            var newArray: [DiaryCard] = []
            for card in array {
                if card.timeStamp == currentCard.timeStamp {
                    newArray.append(currentCard)
                } else {
                    newArray.append(card)
                }
            }
            Global.shared.diaryDict[id] = newArray
        }
    }
    
    private func deleteCard() {
        if let id = Global.shared.selectedPlant?.id, let currentCard = currentDiaryCard {
            let array = Global.shared.diaryDict[id] ?? []
            var newArray: [DiaryCard] = []
            for card in array {
                if card.timeStamp != currentCard.timeStamp {
                    newArray.append(card)
                }
            }
            Global.shared.diaryDict[id] = newArray
        }
    }
    
    private func changeMode(_ mode: DiaryViewMode) {
        currentMode = mode
        switch mode {
            
        case .writeNewDiary, .editDiary:
            let image = UIImage(named: ImageName.completeButton)
            navigationRightButton.setImage(image, for: .normal)
            diaryTextView.isSelectable = true
            diaryTextView.isEditable = true
            addOrSubtractContentView.isHidden = false
            diaryImageHeightConstraint.constant = 266
            setScrollViewHeight()
            
        case .showDiary:
            let image = UIImage(named: ImageName.moreButton)
            navigationRightButton.setImage(image, for: .normal)
            diaryTextView.isSelectable = false
            diaryTextView.isEditable = false
            addOrSubtractContentView.isHidden = true
            
            diaryImageView.image = nil
            if let path = currentDiaryCard?.imageURL, let url = AssetManager.getImageURL(path: path) {
               let provider = LocalFileImageDataProvider(fileURL: url)
               diaryImageView.kf.setImage(with: provider, placeholder: UIImage(), options: nil, progressBlock: nil, completionHandler: { _ in })
            }
            
            diaryDateLabel.text = currentDiaryCard?.timeStamp.getSince1970String()
            if diaryImageView.image == nil {
                diaryImageHeightConstraint.constant = 0
                bigImageButton.isHidden = true
                setScrollViewHeight()
            }
        }
    }
    
    private func showDeleteCardAlert() {
        let alert = UIAlertController(title: "카드를 삭제하시겠습니까?", message: "", preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let deleteAccountAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.deleteCard()
            self.hero.modalAnimationType = .pull(direction: .right)
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancleAction)
        alert.addAction(deleteAccountAction)
        alert.view.tintColor = Color.gray1
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showModifyDeleteAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modifyAction = UIAlertAction(title: "수정", style: .default, handler: { _ in
            self.changeMode(.editDiary)
        })
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            self.showDeleteCardAlert()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler : nil )
        
        alert.addAction(modifyAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.view.tintColor = Color.gray1
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        let velocity = gr.velocity(in: view)
        
        switch gr.state {
        case .began:
            hero.modalAnimationType = .pull(direction: .right)
            if velocity.x > 0 {
                dismiss(animated: true, completion: nil)
            }
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
        
        if currentMode == .writeNewDiary {
            diaryDateLabel.text = Date().timeIntervalSince1970.getSince1970String()
        } else {
            diaryDateLabel.text = currentDiaryCard?.timeStamp.getSince1970String()
        }
        
        if currentDiaryCard?.diaryText == nil {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
            diaryTextView.text = currentDiaryCard?.diaryText
        }
        
        if let identifier = currentDiaryCard?.imageURL {
            diaryImageHeightConstraint.constant = 266
            setScrollViewHeight()
            addOrSubtractContentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            
            if let asset = AssetManager.fetchImages(by: [identifier]).first {
                diaryImageView.fetchHighQualityImage(asset: asset)
            } else {
                diaryImageView.image = nil
            }
            
            let image = UIImage(named: ImageName.minusButton)
            addOrSubtractImageView.image = image
        } else {
            diaryImageHeightConstraint.constant = 0
            bigImageButton.isHidden = true
            setScrollViewHeight()
            addOrSubtractContentView.isHidden = false
            diaryImageView.image = nil
            addOrSubtractContentView.backgroundColor = Color.gray6
            
            let image = UIImage(named: ImageName.plusButton)
            addOrSubtractImageView.image = image
        }
    }
    
    private func setTextView() {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let atributes = [NSAttributedString.Key.paragraphStyle: style ]
        diaryTextView.attributedText = NSAttributedString(string: diaryTextView.text, attributes: atributes)
        diaryTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        diaryTextView.textColor = Color.gray3
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        
        diaryTextView.delegate = self
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            
            contentHeightConstraint.constant = view.frame.height + keyboardHeight
            textViewHeightConstraint.constant = scrollView.frame.height - keyboardHeight - 25
            
            scrollView.contentOffset.y = 350
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset.y = 0
        textViewHeightConstraint.constant = diaryTextView.contentSize.height + 10
        setScrollViewHeight()
    }
    
    @objc func endEdit(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setScrollViewHeight() {
        contentHeightConstraint.constant = diaryImageHeightConstraint.constant + 87 + textViewHeightConstraint.constant + 50
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textViewHeightConstraint.constant = diaryTextView.contentSize.height + 10
        setScrollViewHeight()
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
}

extension DiaryViewController: SelectPhotoDelegate {
    func photoSelected(_ photoAsset: PHAsset) {
        selectedImage = photoAsset
        diaryImageView.fetchHighQualityImage(asset: photoAsset)
        let image = UIImage(named: ImageName.minusButton)
        addOrSubtractContentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        addOrSubtractImageView.image = image
    }
}

extension DiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
}
