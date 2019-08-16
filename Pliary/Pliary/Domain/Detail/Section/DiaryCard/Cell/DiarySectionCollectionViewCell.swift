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
    @IBOutlet weak var tableView: UITableView!
    
    var diaryCards: [DiaryCard] = []
    weak var delegate: DetailEventDelegate?
    
    private var diaryCardsCount: Int {
        return diaryCards.count + 2
    }
    
    @IBAction func tapWriteButton(_ sender: Any) {
        delegate?.detailEvent(event: .goDiaryViewController(with: nil))
    }
    
    private func setExample() {
        let text = "너에게해충이찾아왔다다지켜주지못해 미안해다음부턴잘할게다못난날용서해잘할게다못난날용서해날용서해용서해너에게해충이찾아왔다다지켜주지못해 미안해다음부턴잘할게다못난날용서해잘할게다못난날용서해날용서해용서해"
        let diary = DiaryCard(timeStamp: "2019.11.02", diaryText: text, diaryImage: UIImage(named: "SampleDiary"))
        let diary2 = DiaryCard(timeStamp: "2019.11.02", diaryText: text, diaryImage: nil)
        
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary2)
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
        diaryCards.append(diary)
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
        
        let emptyCellName = EmptyTableViewCell.reuseIdentifier
        let emptyCellNib = UINib(nibName: emptyCellName, bundle: nil)
        tableView.register(emptyCellNib, forCellReuseIdentifier: emptyCellName)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setExample()
        setTableView()
    }

}

extension DiarySectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
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
        } else if indexPath.row == diaryCardsCount - 1, let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.reuseIdentifier) as? EmptyTableViewCell {
            
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
