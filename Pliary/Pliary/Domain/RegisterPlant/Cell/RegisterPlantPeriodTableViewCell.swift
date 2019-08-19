//
//  RegisterPlantPeriodTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class RegisterPlantPeriodTableViewCell: UITableViewCell, RegisterCell {
    
    var type: RegisterRowType?
    var plant: Plant?
    private var gradient: CAGradientLayer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let numberNib = UINib(nibName: NumberCollectionViewCell.identifier, bundle: nil)
        collectionView.register(numberNib, forCellWithReuseIdentifier: NumberCollectionViewCell.identifier)
    }
    
    func setUp(with plant: Plant, type: RegisterRowType) {
        self.plant = plant
        self.type = type
        setGradientScript()
    }
    
    func setGradientScript() {
        gradient = CAGradientLayer()
        gradient?.startPoint = CGPoint(x: 0, y: 0.5)
        gradient?.endPoint = CGPoint(x:1.0, y:0.5)
        gradient?.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient?.locations = [0, 0.45, 0.55, 1]
        
        gradient?.frame = collectionView.bounds
        collectionView.superview?.layer.mask = gradient
    }
}

extension RegisterPlantPeriodTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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

extension RegisterPlantPeriodTableViewCell: UICollectionViewDataSource {
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


