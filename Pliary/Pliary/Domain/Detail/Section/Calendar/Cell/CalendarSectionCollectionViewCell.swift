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

    var recordCards: [String] = []
    var planCards: String = ""
    
    weak var delegate: DetailEventDelegate?

    private var recordCardsCount: Int {
        return recordCards.count + 2
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
    }

    func setUp() {
        if let id = Global.shared.selectedPlant?.id, let dict = Global.shared.waterRecordDict[id] {
            recordCards = []
            for date in dict {
                recordCards.append(date.getSince1970String())
            }
            recordCards = recordCards.sorted().reversed()
            planCards = Global.shared.selectedPlant?.getNextWaterDate().getSince1970String() ?? ""
        }
        
        if recordCards.isEmpty {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        setTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NotificationName.reloadWateringRecord, object: nil)
    }

    @objc func reloadData() {
        setUp()
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NotificationName.reloadWateringRecord, object: nil)
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
            cell.setUp()
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: WateringInfoTableViewCell.identifier) as? WateringInfoTableViewCell {
            
            if indexPath.row == 1 {
                cell.setUp(planCards, isTodo: true)
            } else {
                let index = indexPath.row - 2
                if recordCards.count > index {
                    let dateStr = recordCards[index]
                    cell.setUp(dateStr, isTodo: false)
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }

}
