//
//  SectionTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: DetailEventDelegate?
    
    func changeSection(to section: Section, animated: Bool) {
        switch section {
        case .diaryCard:
            let index = IndexPath(item: 0, section: 0)
            collectionView.scrollToItem(at: index, at: .left, animated: true)
        case .calendar:
            let index = IndexPath(item: 1, section: 0)
            collectionView.scrollToItem(at: index, at: .left, animated: true)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        
        let diaryNib = UINib(nibName: DiarySectionCollectionViewCell.identifier, bundle: nil)
        collectionView.register(diaryNib, forCellWithReuseIdentifier: DiarySectionCollectionViewCell.identifier)
        
        let calendarNib = UINib(nibName: CalendarSectionCollectionViewCell.identifier, bundle: nil)
        collectionView.register(calendarNib, forCellWithReuseIdentifier: CalendarSectionCollectionViewCell.identifier)
    }
    
}

extension SectionTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension SectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiarySectionCollectionViewCell.identifier, for: indexPath) as? DiarySectionCollectionViewCell {
            cell.setUp()
            cell.delegate = self
            return cell
        } else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarSectionCollectionViewCell.identifier, for: indexPath) as? CalendarSectionCollectionViewCell {
            cell.setUp()
            cell.delegate = self
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Perform whichever function you desire for when scrolling has stopped
        if collectionView.contentOffset.x <= frame.width / 2 {
            delegate?.detailEvent(event: .changeSectionToDiary)
        } else {
            delegate?.detailEvent(event: .changeSectionToCalendar)
        }
    }
    
}

extension SectionTableViewCell: DetailEventDelegate {
    func detailEvent(event: DetailLayoutEvent) {
        delegate?.detailEvent(event: event)
    }
    
    func detailEvent(_ plant: Plant, event: PlantEvent) {
        delegate?.detailEvent(plant, event: event)
    }
    
    func detailEvent(_ diaryCard: DiaryCard, event: DetailDiaryCardEvent) {
        delegate?.detailEvent(diaryCard, event: event)
    }
    
}
