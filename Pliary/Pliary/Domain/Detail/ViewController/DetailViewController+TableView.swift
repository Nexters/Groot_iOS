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
        }
        
        // Diary Card
        if currentSection == .diaryCard {
            if indexPath.row == 0 {
                return DayWithPlantTableViewCell.height
            } else if indexPath.row == diaryCardsCount - 1 {
                
                var height = tableView.frame.height
                
                height = height - DetailTableHeaderView.height
                height = height - DayWithPlantTableViewCell.height
                height = height - (DiaryCardWithAllTableViewCell.height * CGFloat(diaryCards.count))
                
                if height > 0 {
                    return height
                } else {
                    return 0
                }
                
            } else {
                return DiaryCardWithAllTableViewCell.height
            }
        }
        
        // Calendar
        if currentSection == .calendar {
            if indexPath.row == 0 {
                return CalendarTableViewCell.height
            } else if indexPath.row == recordCardsCount - 1 {
                
                var height = tableView.frame.height
                
                height = height - DetailTableHeaderView.height
                height = height - CalendarTableViewCell.height
                height = height - (WateringInfoTableViewCell.height * CGFloat(recordCards.count))
                
                if height > 0 {
                    return height
                } else {
                    return 0
                }
                
            } else {
                return WateringInfoTableViewCell.height
            }
        }
        
        return 0
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
        } else if currentSection == .diaryCard {
            return diaryCardsCount
        } else {
            return recordCardsCount
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let headerView = DetailTableHeaderView.instance(with: currentSection)
            headerView.delegate = self
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailTableViewCell.reuseIdentifier) as? MainDetailTableViewCell {
                
                cell.setUp(with: selectedPlant)
                cell.delegate = self
                
                return cell
            }
        }
        
        // Diary Card
        if currentSection == .diaryCard {
            if indexPath.row == 0,  let cell = tableView.dequeueReusableCell(withIdentifier: DayWithPlantTableViewCell.reuseIdentifier) as? DayWithPlantTableViewCell {
                
                return cell
            }  else if indexPath.row == diaryCardsCount - 1, let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.reuseIdentifier) as? EmptyTableViewCell {
                
                if diaryCards.isEmpty {
                    cell.growthLabel.isHidden = false
                }
                
                return cell
            } else if let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCardWithAllTableViewCell.reuseIdentifier) as? DiaryCardWithAllTableViewCell {
                
                let diaryCard = diaryCards[indexPath.row - 1]
                cell.setUp(with: diaryCard)
                cell.delegate = self
                
                return cell
            }
        }
        
        // Calendar
        if currentSection == .calendar {
            if indexPath.row == 0,  let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.identifier) as? CalendarTableViewCell {
                
                return cell
            } else if indexPath.row == recordCardsCount - 1, let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.reuseIdentifier) as? EmptyTableViewCell {
                
                return cell
            } else if let cell = tableView.dequeueReusableCell(withIdentifier: WateringInfoTableViewCell.identifier) as? WateringInfoTableViewCell {
                
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
