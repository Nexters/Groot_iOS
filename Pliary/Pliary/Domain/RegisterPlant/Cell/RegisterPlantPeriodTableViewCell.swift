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
}

extension RegisterPlantPeriodTableViewCell: UICollectionViewDataSource {
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


