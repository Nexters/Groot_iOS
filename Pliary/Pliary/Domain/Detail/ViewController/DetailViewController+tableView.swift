//
//  DetailViewController+tableView.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

extension DetailViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        animatePlant(false)
        
        if scrollView.contentOffset.y < tableView.frame.height {
            tableView.isPagingEnabled = true
            tableView.bounces = false
            writeDiaryButton.isHidden = true
        } else if scrollView.contentOffset.y == tableView.frame.height {
            tableView.isPagingEnabled = true
            tableView.bounces = false
            writeDiaryButton.isHidden = false
        } else {
            tableView.isPagingEnabled = false
            tableView.bounces = true
            writeDiaryButton.isHidden = false
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableView.isDecelerating == false {
            // Perform whichever function you desire for when scrolling has stopped
            animatePlant(true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Perform whichever function you desire for when scrolling has stopped
        animatePlant(true)
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return tableView.frame.height
        } else if currentSection == .diaryCard, indexPath.row == 0 {
            return DayWithPlantTableViewCell.height
        } else {
            return DiaryCardWithAllTableViewCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return DetailTableHeaderView.height
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return diaryCardsCount
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let headerView = DetailTableHeaderView.instance(with: currentSection)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailTableViewCell.reuseIdentifier) as? MainDetailTableViewCell {
                cell.setUp(with: selectedPlant)
                return cell
            }
        } else if indexPath.row == 0 {
            if currentSection == .diaryCard, let cell = tableView.dequeueReusableCell(withIdentifier: DayWithPlantTableViewCell.reuseIdentifier) as? DayWithPlantTableViewCell {
                return cell
            }
        } else {
            if currentSection == .diaryCard, let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCardWithAllTableViewCell.reuseIdentifier) as? DiaryCardWithAllTableViewCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            // resume animation
        } else if currentSection == .diaryCard, indexPath.row != 0  {
            let diaryCard = diaryCards[indexPath.row - 1]
            goDiaryViewController(with: diaryCard)
        }
    }
    
}
