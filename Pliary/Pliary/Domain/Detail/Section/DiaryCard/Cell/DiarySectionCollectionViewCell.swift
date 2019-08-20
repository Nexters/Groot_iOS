//
//  SectionCollectionViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class DiarySectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var growthLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: DetailEventDelegate?
    
    var diaryCards: [DiaryCard] = [] {
        didSet {
            if diaryCards.isEmpty {
                growthLabel.isHidden = false
                tableView.isScrollEnabled = false
            } else {
                growthLabel.isHidden = true
                tableView.isScrollEnabled = true
            }
        }
    }
    
    private var diaryCardsCount: Int {
        return diaryCards.count + 1
    }
    
    @IBAction func tapWriteButton(_ sender: Any) {
        delegate?.detailEvent(event: .goDiaryViewController(with: nil))
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let dayWithPlantName = DayWithPlantTableViewCell.reuseIdentifier
        let dayWithPlantNib = UINib(nibName: dayWithPlantName, bundle: nil)
        tableView.register(dayWithPlantNib, forCellReuseIdentifier: dayWithPlantName)
        
        let diaryCardWithAllName = DiaryCardWithAllTableViewCell.reuseIdentifier
        let diaryCardWithAllNib = UINib(nibName: diaryCardWithAllName, bundle: nil)
        tableView.register(diaryCardWithAllNib, forCellReuseIdentifier: diaryCardWithAllName)
        
        let diaryCardWithImageName = DiaryCardWithImageTableViewCell.reuseIdentifier
        let diaryCardWithImageNib = UINib(nibName: diaryCardWithImageName, bundle: nil)
        tableView.register(diaryCardWithImageNib, forCellReuseIdentifier: diaryCardWithImageName)
        
        let diaryCardWithTextName = DiaryCardWithTextTableViewCell.reuseIdentifier
        let diaryCardWithTextNib = UINib(nibName: diaryCardWithTextName, bundle: nil)
        tableView.register(diaryCardWithTextNib, forCellReuseIdentifier: diaryCardWithTextName)
        
        if diaryCards.isEmpty {
            growthLabel.isHidden = false
            tableView.isScrollEnabled = false
        } else {
            growthLabel.isHidden = true
            tableView.isScrollEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTableView()
    }
    
    func setUp(with plant: Plant?) {
        if let id = plant?.id {
            diaryCards = Global.shared.diaryDict[id] ?? []
        }
    }

}

extension DiarySectionCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0  {
            let diaryCard = diaryCards[indexPath.row - 1]
            delegate?.detailEvent(event: .goDiaryViewController(with: diaryCard))
        }
    }
}

extension DiarySectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryCardsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: DayWithPlantTableViewCell.reuseIdentifier) as? DayWithPlantTableViewCell {
            
            return cell
        }
        
        let diaryCard = diaryCards[indexPath.row - 1]
        
        if diaryCard.diaryText == nil , let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCardWithImageTableViewCell.reuseIdentifier) as? DiaryCardWithImageTableViewCell {
            
            let diaryCard = diaryCards[indexPath.row - 1]
            cell.setUp(with: diaryCard)
            cell.delegate = self
            
            return cell
        }
            
        if diaryCard.diaryImage == nil, let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCardWithTextTableViewCell.reuseIdentifier) as? DiaryCardWithTextTableViewCell {
            
            let diaryCard = diaryCards[indexPath.row - 1]
            cell.setUp(with: diaryCard)
            cell.delegate = self
            
            return cell
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCardWithAllTableViewCell.reuseIdentifier) as? DiaryCardWithAllTableViewCell {
            
            let diaryCard = diaryCards[indexPath.row - 1]
            cell.setUp(with: diaryCard)
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension DiarySectionCollectionViewCell: DetailEventDelegate {
    func detailEvent(event: DetailLayoutEvent) {
        delegate?.detailEvent(event: event)
    }
    
    func detailEvent(_ plant: Plant, event: DetailPlantEvent) {
        delegate?.detailEvent(plant, event: event)
    }
    
    func detailEvent(_ diaryCard: DiaryCard, event: DetailDiaryCardEvent) {
        delegate?.detailEvent(diaryCard, event: event)
    }
    
}
