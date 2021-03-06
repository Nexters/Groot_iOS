//
//  DetailViewController+tableView.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

extension DetailViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y <= 20 {
            animatePlant(true)
        } else if animating {
            animatePlant(false)
        }
        
        if scrollView.contentOffset.y < -3 && !first {
            Global.shared.selectedPlant = nil
            dismiss(animated: true, completion: nil)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Perform whichever function you desire for when scrolling has stopped
        animatePlant(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return tableView.frame.height
        } else {
            return tableView.frame.height - DetailTableHeaderView.height
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let headerView = DetailTableHeaderView.instance(with: currentSection)
            headerView.delegate = self
            self.headerView = headerView
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailTableViewCell.reuseIdentifier) as? MainDetailTableViewCell {
                cell.delegate = self
                cell.setUp()
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.reuseIdentifier) as? SectionTableViewCell {
                
                if layoutFirst == true && first == false {
                    layoutFirst = false
                    cell.collectionView.reloadData()
                }
                
                cell.delegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}
