//
//  HomeViewController+Segue.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Delegate UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    @IBAction func tabProfileImageButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: StoryboardName.setting, bundle: Bundle(for: SettingViewController.self))
        guard let settingVC = storyboard.instantiateViewController(withIdentifier: SettingViewController.identifier) as? SettingViewController else {
            return
        }
        
        settingVC.hero.isEnabled = true
        settingVC.hero.modalAnimationType = .push(direction: .left)
        present(settingVC, animated: true, completion: nil)
    }
    
    func enableHero(view: UIView, id: String) {
        view.hero.isEnabled = true
        view.hero.id = id
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        
        if let cell = selectedCell as? HomeCardCollectionViewCell {
            goDetailViewController(with: cell)
        } else if (selectedCell as? AddCardCollectionViewCell) != nil {
            goRegisterViewController()
        }
        
    }
    
    func goRegisterViewController() {
        let storyboard = UIStoryboard.init(name: StoryboardName.regiserPlant, bundle: Bundle(for: RegisterPlantViewController.self))
        guard let registerVC = storyboard.instantiateViewController(withIdentifier: RegisterPlantViewController.identifier) as? RegisterPlantViewController else {
            return
        }
        
        present(registerVC, animated: true, completion: nil)
    }
    
    func goDetailViewController(with selectedCell: HomeCardCollectionViewCell) {
        guard let plant = selectedCell.plant else {
            return
        }
        
        let englishNameID = "englishName"
        let koreanNameID = "koreanName"
        let customNameID = "customName"
        let splitName = "splitName"
        
        let cellID = "plantCell\(plant.id)"
        let plantID = "plantImage\(plant.id)"
        let addWaterID = "addWater\(plant.id)"
        let blackWaterID = "blackWater\(plant.id)"
        let dayLeftID = "dayLeft\(plant.id)"
        
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
        
        Global.shared.selectedPlant = selectedCell.plant
        
        enableHero(view: detailVC.view, id: cellID)
        
        let index = IndexPath.init(row: 0, section: 0)
        detailVC.setUpTableView()
        detailVC.tableView.reloadData()
        detailVC.tableView.hero.isEnabled = true
        
        guard let detailCell = detailVC.tableView.cellForRow(at: index) as? MainDetailTableViewCell else {
            
            present(detailVC, animated: true, completion: nil)
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
        
        if let image = selectedCell.plantView.image {
            detailCell.plantView.image = image
            present(detailVC, animated: true, completion: {
                detailCell.animateImage()
            })
        }
    }
}

extension HomeViewController: HomeEventDelegate {
    func homeEvent(_ plant: Plant, event: HomeEvent) {
        switch event {
        case .waterToPlant:
            let waterPopup = WateringPopupView.instance(with: plant)
            waterPopup.frame = view.frame
            waterPopup.setSelectView()
            view.addSubview(waterPopup)
        }
    }
}
