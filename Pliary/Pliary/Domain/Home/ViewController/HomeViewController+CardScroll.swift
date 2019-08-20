//
//  HomeViewController+CardScroll.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

extension HomeViewController {
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewLayout.itemSize.width
        let proportionalOffset = collectionView.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(plantsCount - 1, index))
        
        return safeIndex
    }
    
    func adjustInset() {
        let inset: CGFloat = 40
        let unitScrollSize: CGFloat = collectionView.frame.size.width - inset * 2
        let currentIndex = collectionView.contentOffset.x / unitScrollSize
        
        collectionView.visibleCells.forEach {
            let index = Int($0.center.x / unitScrollSize)
            let difference = abs(CGFloat(index) - currentIndex)
            let topConstraint = difference * 20
            
            if let cell = $0 as? HomeCardCollectionViewCell {
                cell.stopImage()
                cell.topLayoutConstraint.constant = topConstraint
            } else if let cell = $0 as? AddCardCollectionViewCell {
                cell.topLayoutConstraint.constant = topConstraint
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        adjustInset()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            animateCell()
        }
    }
    
    func animateCell() {
        // For CPU 
        let inset: CGFloat = 40
        let unitScrollSize: CGFloat = collectionView.frame.size.width - inset * 2
        let currentIndex = collectionView.contentOffset.x / unitScrollSize
        let indexPath = IndexPath(item: Int(currentIndex), section: 0)
        
        adjustInset()
        
        if let cell = collectionView.cellForItem(at: indexPath) as? HomeCardCollectionViewCell {
            englishNameLabel.text = cell.plant?.englishName
            koreanNameLabel.text = cell.plant?.koreanName
            customNameLabel.text = cell.plant?.nickName
            nameSplitLabel.isHidden = false
            cell.animateImage()
        } else {
            englishNameLabel.text = "Add Plant"
            koreanNameLabel.text = "식물을 추가해주세요."
            nameSplitLabel.isHidden = true
            customNameLabel.text = nil
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        animateCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()
        
        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < plantsCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewLayout.itemSize.width * CGFloat(snapToIndex)
            
            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: { _ in
                self.adjustInset()
                self.animateCell()
            })
            
            slideViewLeadingConstraint.constant = CGFloat(snapToIndex) * slideViewWidthConstraint.constant
        } else {
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            slideViewLeadingConstraint.constant = CGFloat(indexOfMajorCell) * slideViewWidthConstraint.constant
        }
    }
}

// MARK: - Delegate UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plantsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == (plants.count) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCardCollectionViewCell.reuseIdentifier, for: indexPath) as? AddCardCollectionViewCell ?? AddCardCollectionViewCell()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCardCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCardCollectionViewCell ?? HomeCardCollectionViewCell()
            let plant = plants[indexPath.item]
            cell.setUp(with: plant)
            cell.delegate = self
            return cell
        }
    }
}
