//
//  DayWithPlantTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 08/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class DayWithPlantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayWithPlantLabel: UILabel!
    @IBOutlet weak var dayWithLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(setUp), name: NotificationName.reloadSelectedPlant, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NotificationName.reloadSelectedPlant, object: nil)
    }
    
    func daysBetween(start: Date, end: Date) -> Int? {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)
    }
    
    @objc func setUp() {
        guard let plant = Global.shared.selectedPlant else {
            return
        }
        
        let today = Date()
        let firstDay = Date(timeIntervalSince1970: plant.firstDate)
        
        if let day = daysBetween(start: firstDay, end: today) {
            dayWithLabel.text = (day + 1).description + "일"
            dayWithPlantLabel.text = (Global.shared.selectedPlant?.nickName ?? "") + " 식물과 " + (day + 1).description + "일을 함께 했어요!"
        }
        
    }
    
}
