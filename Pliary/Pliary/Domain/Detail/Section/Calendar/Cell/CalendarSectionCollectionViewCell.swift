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
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    fileprivate let formatterForCell: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()

    private func setUp(_ plant : Plant) {
        let dates = plant.getWaterDates()
        
        for _ in dates {
            let wateringInfoName = WateringInfoTableViewCell.reuseIdentifier
            let wateringInfoNib = UINib(nibName: wateringInfoName, bundle: nil)
            tableView.register(wateringInfoNib, forCellReuseIdentifier: wateringInfoName)
            
            let card = RecordCard(dayCompareToSchedule: 0)
            recordCards.append(card)
        }
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let calendarName = CalendarTableViewCell.reuseIdentifier
        let calendarNib = UINib(nibName: calendarName, bundle: nil)
        tableView.register(calendarNib, forCellReuseIdentifier: calendarName)
        
        let plant = Global.shared.selectedPlant
        let dates = plant?.getWaterDatesTodo()
        
        let wateringInfoName = WateringInfoTableViewCell.reuseIdentifier
        let wateringInfoNib = UINib(nibName: wateringInfoName, bundle: nil)
        tableView.register(wateringInfoNib, forCellReuseIdentifier: wateringInfoName)
        
        let i: Int = dates?.count ?? 0
        for _ in 0..<i {
            let wateringInfoName = WateringInfoTableViewCell.reuseIdentifier
            let wateringInfoNib = UINib(nibName: wateringInfoName, bundle: nil)
            tableView.register(wateringInfoNib, forCellReuseIdentifier: wateringInfoName)
        }
        
        if recordCards.isEmpty {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let plant = Global.shared.selectedPlant else { return }
        setUp(plant)
        setTableView()
    }

}

extension CalendarSectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CalendarTableViewCell.height
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
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: WateringInfoTableViewCell.identifier) as? WateringInfoTableViewCell {
            let index = indexPath.row - 1
            let plant = Global.shared.selectedPlant
            let dates = plant?.getWaterDates()
            if(dates?.count ?? 0 > index ){
                let dateStr = String(dates?[index] ?? "")
                cell.setUp(dateStr, isTodo: false)
            } else {
                let date = Date(timeIntervalSince1970: TimeInterval(plant?.getNextWaterDate() ?? 0))
                let dateStr = formatterForCell.string(from: date)
                cell.setUp(dateStr, isTodo: true)
            }
            return cell
        }
        return UITableViewCell()
    }

}
