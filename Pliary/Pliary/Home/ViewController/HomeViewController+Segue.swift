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
        
        if let cell = collectionView.cellForItem(at: indexPath) as? HomeCardCollectionViewCell {
            cell.hero.isEnabled = true
            cell.contentView.hero.modifiers = [.cascade]
            
            enableHero(view: cell.plantView, id: plantID)
            enableHero(view: cell.addWaterButton, id: addWaterID)
            enableHero(view: cell.blackWaterImageView, id: blackWaterID)
            enableHero(view: cell.dayLeftLabel, id: dayLeftID)
            enableHero(view: cell.contentView, id: cellID)
        } else {
            return
        }
        
        let storyboard = UIStoryboard.init(name: StoryboardName.detail, bundle: Bundle(for: DetailViewController.self))
        if let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController {
            
            detailVC.hero.isEnabled = true
            detailVC.hero.modalAnimationType = .none
            detailVC.view.hero.modifiers = [.cascade]
            
            enableHero(view: detailVC.view, id: cellID)
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            detailVC.setUpTableView()
            detailVC.tableView.reloadData()
            detailVC.tableView.hero.isEnabled = true
            
            if let cell = detailVC.tableView.cellForRow(at: indexPath) as? MainDetailTableViewCell {
                
                enableHero(view: cell.plantView, id: plantID)
                enableHero(view: cell.addWaterButton, id: addWaterID)
                enableHero(view: cell.blackWaterImageView, id: blackWaterID)
                enableHero(view: cell.dayLeftLabel, id: dayLeftID)
                enableHero(view: cell.englishNameLabel, id: englishNameID)
                enableHero(view: cell.koreanNameLabel, id: koreanNameID)
                enableHero(view: cell.customNameLabel, id: customNameID)
                enableHero(view: cell.nameSplitLabel, id: splitName)
            }
            
            present(detailVC, animated: true, completion: nil)
        }
    }
}
