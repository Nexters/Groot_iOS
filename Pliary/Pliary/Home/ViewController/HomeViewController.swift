//
//  HomeViewController.swift
//  
//
//  Created by jueun lee on 2019. 7. 31..
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var customNameLabel: UILabel!
    
    @IBOutlet weak var slideBackgroundView: UIView!
    @IBOutlet weak var selectedSlideView: UIView!
    @IBOutlet weak var slideViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var slideViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    private var indexOfCellBeforeDragging = 0
    
    var plants: [Plant] = [] {
        didSet {
            slideViewWidthConstraint.constant = slideBackgroundView.frame.width / CGFloat(plantsCount)
        }
    }
    var plantsCount: Int {
        return plants.count + 1
    }
    
    @IBAction func tabProfileImageButton(_ sender: Any) {
        
    }
    
    private func setUpSlideView() {
        slideBackgroundView.clipsToBounds = true
        selectedSlideView.clipsToBounds = true
        
        slideBackgroundView.layer.cornerRadius = slideBackgroundView.frame.height / 2
        selectedSlideView.layer.cornerRadius = selectedSlideView.frame.height / 2
    }
    
    private func setUpCollectionView() {
        let homeCardName = HomeCardCollectionViewCell.reuseIdentifier
        let homeCardNib = UINib(nibName: homeCardName, bundle: nil)
        let addCardName = AddCardCollectionViewCell.reuseIdentifier
        let addCardNib = UINib(nibName: addCardName, bundle: nil)
        
        collectionView.register(homeCardNib, forCellWithReuseIdentifier: homeCardName)
        collectionView.register(addCardNib, forCellWithReuseIdentifier: addCardName)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewLayout.minimumLineSpacing = 0
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = 40
        let indexPath = IndexPath.init(item: 0, section: 0)
        let firstCell = collectionView.cellForItem(at: indexPath)
        
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionViewLayout.itemSize = CGSize(width: collectionView.frame.size.width - inset * 2, height: collectionView.frame.size.height)
        
        if let cell = firstCell as? HomeCardCollectionViewCell {
            cell.topLayoutConstraint.constant = 0
        } else if let cell = firstCell as? AddCardCollectionViewCell {
            cell.topLayoutConstraint.constant = 0
        }
    }
    
    func setExample() {
        let plant = Plant.init(name: "", species: "", drinkingDay: 0)
        plants.append(plant)
        plants.append(plant)
        plants.append(plant)
        plants.append(plant)
    }
    
}

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setExample()
        setUpCollectionView()
        setUpSlideView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionViewLayoutItemSize()
    }
}

// MARK: - Delegate UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewLayout.itemSize.width
        let proportionalOffset = collectionView.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(plantsCount - 1, index))
        
        return safeIndex
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let inset: CGFloat = 40
        let unitScrollSize: CGFloat = collectionView.frame.size.width - inset * 2
        let currentIndex = scrollView.contentOffset.x / unitScrollSize
        
        collectionView.visibleCells.forEach {
            let index = Int($0.center.x / unitScrollSize)
            let difference = abs(CGFloat(index) - currentIndex)
            let topConstraint = difference * 20
            
            if let cell = $0 as? HomeCardCollectionViewCell {
                cell.topLayoutConstraint.constant = topConstraint
            } else if let cell = $0 as? AddCardCollectionViewCell {
                cell.topLayoutConstraint.constant = topConstraint
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
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
            }, completion: nil)
            
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
            
            return cell
        }
    }
}

