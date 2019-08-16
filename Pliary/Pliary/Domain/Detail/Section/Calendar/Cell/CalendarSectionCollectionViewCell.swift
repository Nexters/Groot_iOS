//
//  CalendarSectionCollectionViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class CalendarSectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    var recordCards: [RecordCard] = []
    weak var delegate: DetailEventDelegate?
    
    private var recordCardsCount: Int {
        return recordCards.count + 2
    }
    
    private func setExample() {
        let card = RecordCard(timeStamp: "2019.11.02", dayCompareToSchedule: 0)
        recordCards.append(card)
        recordCards.append(card)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let calendarName = CalendarTableViewCell.reuseIdentifier
        let calendarNib = UINib(nibName: calendarName, bundle: nil)
        tableView.register(calendarNib, forCellReuseIdentifier: calendarName)
        
        let wateringInfoName = WateringInfoTableViewCell.reuseIdentifier
        let wateringInfoNib = UINib(nibName: wateringInfoName, bundle: nil)
        tableView.register(wateringInfoNib, forCellReuseIdentifier: wateringInfoName)
        
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

extension CalendarSectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
}

extension CalendarSectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordCardsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0,  let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.identifier) as? CalendarTableViewCell {
            
            return cell
        } else if indexPath.row == recordCardsCount - 1, let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.reuseIdentifier) as? EmptyTableViewCell {
            
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: WateringInfoTableViewCell.identifier) as? WateringInfoTableViewCell {
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
