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
        return recordCards.count + 1
    }
    
    private func setExample() {
        let card = RecordCard(timeStamp: "2019.11.02", dayCompareToSchedule: 0)
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
        
        if recordCards.isEmpty {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setExample()
        setTableView()
    }

}

extension CalendarSectionCollectionViewCell: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
            delegate?.detailEvent(event: .scrollToPreviousPage)
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
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: WateringInfoTableViewCell.identifier) as? WateringInfoTableViewCell {
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
