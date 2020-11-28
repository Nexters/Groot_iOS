//
//  SelectPhotoViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 22/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Photos

class SelectPhotoViewController: UIViewController {
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: SelectPhotoDelegate?
    
    private var selectedPhoto: PHAsset? {
        didSet {
            if selectedPhoto == nil {
                completeButton.isEnabled = false
                completeButton.alpha = 0.5
            } else {
                completeButton.isEnabled = true
                completeButton.alpha = 1
            }
        }
    }
    
    private var photos: [PHAsset] = [] {
        didSet {
            if oldValue != photos {
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapChooseButton(_ sender: Any) {
        guard let photo = selectedPhoto else {
            return
        }
        
        delegate?.photoSelected(photo)
        dismiss(animated: true, completion: nil)
    }
    
    private func getImages (){
        photos = AssetManager.fetchImages(by: nil)
    }
    
    private func setCollectionView() {
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        
        let nib = UINib(nibName: SelectPhotoCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SelectPhotoCollectionViewCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension SelectPhotoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        completeButton.isEnabled = false
        completeButton.alpha = 0.5
        
        PHPhotoLibrary.requestAuthorization({ [weak self]
            (newStatus) in
            if newStatus == PHAuthorizationStatus.authorized {
                self?.getImages()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PHPhotoLibrary.shared().register(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
}


extension SelectPhotoViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        getImages()
    }
}

extension SelectPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 3) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension SelectPhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectPhotoCollectionViewCell {
            selectedPhoto = cell.photo
            cell.check()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectPhotoCollectionViewCell {
            cell.uncheck()
        }
    }
}

extension SelectPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photo = photos[safe: indexPath.item] else {
            return UICollectionViewCell()
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? SelectPhotoCollectionViewCell {
            cell.setUp(with: photo)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
