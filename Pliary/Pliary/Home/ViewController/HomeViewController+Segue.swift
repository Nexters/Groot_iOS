//
//  HomeViewController+Segue.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

// MARK: - Delegate UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func enableHero(view: UIView, id: String) {
        view.hero.isEnabled = true
        view.hero.id = id
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? HomeCardCollectionViewCell else {
            return
        }
        
        let englishNameID = "englishName"
        let koreanNameID = "koreanName"
        let customNameID = "customName"
        let splitName = "splitName"
        
        let cellID = "plantCell\(indexPath.item)"
        let plantID = "plantImage\(indexPath.item)"
        let addWaterID = "addWater\(indexPath.item)"
        let blackWaterID = "blackWater\(indexPath.item)"
        let dayLeftID = "dayLeft\(indexPath.item)"
        
        view.bringSubviewToFront(englishNameLabel)
        view.bringSubviewToFront(koreanNameLabel)
        view.bringSubviewToFront(customNameLabel)
        view.bringSubviewToFront(nameSplitLabel)
        
        enableHero(view: englishNameLabel, id: englishNameID)
        enableHero(view: koreanNameLabel, id: koreanNameID)
        enableHero(view: customNameLabel, id: customNameID)
        enableHero(view: nameSplitLabel, id: splitName)
        
        selectedCell.hero.isEnabled = true
        selectedCell.contentView.hero.modifiers = [.cascade]
        
        enableHero(view: selectedCell.plantView, id: plantID)
        enableHero(view: selectedCell.addWaterButton, id: addWaterID)
        enableHero(view: selectedCell.blackWaterImageView, id: blackWaterID)
        enableHero(view: selectedCell.dayLeftLabel, id: dayLeftID)
        enableHero(view: selectedCell.contentView, id: cellID)
        
        let storyboard = UIStoryboard.init(name: StoryboardName.detail, bundle: Bundle(for: DetailViewController.self))
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else {
            return
        }
        
        detailVC.hero.isEnabled = true
        detailVC.hero.modalAnimationType = .none
        detailVC.view.hero.modifiers = [.cascade]
        
        enableHero(view: detailVC.view, id: cellID)
        
        
        let index = IndexPath.init(row: 0, section: 0)
        detailVC.setUpTableView()
        detailVC.tableView.reloadData()
        detailVC.tableView.hero.isEnabled = true
        
        guard let detailCell = detailVC.tableView.cellForRow(at: index) as? MainDetailTableViewCell else {
            return
        }
        
        enableHero(view: detailCell.plantView, id: plantID)
        enableHero(view: detailCell.addWaterButton, id: addWaterID)
        enableHero(view: detailCell.blackWaterImageView, id: blackWaterID)
        enableHero(view: detailCell.dayLeftLabel, id: dayLeftID)
        enableHero(view: detailCell.englishNameLabel, id: englishNameID)
        enableHero(view: detailCell.koreanNameLabel, id: koreanNameID)
        enableHero(view: detailCell.customNameLabel, id: customNameID)
        enableHero(view: detailCell.nameSplitLabel, id: splitName)
        
        present(detailVC, animated: true, completion: nil)
    }
}
