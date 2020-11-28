//
//  CalendarTableViewCell.swift
//  Pliary
//
//  Created by jeewoong.han on 16/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarTableViewCell: UITableViewCell, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    static let height: CGFloat = 427

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarView: UIView!
    var first = true

    var dates: [String] = [] {
        didSet {
            if oldValue != dates {
                calendar.reloadData()
            }
        }
    }
    
    var nextWaterDate = "" {
        didSet {
            if oldValue != nextWaterDate {
                calendar.reloadData()
            }
        }
    }

    fileprivate let gregorian = Calendar(identifier: .gregorian)

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        calendar.delegate = self
        calendar.dataSource = self
        setUpCalendar()
    }
    
    func setUp() {
        if let id = Global.shared.selectedPlant?.id, let dict = Global.shared.waterRecordDict[id] {
            dates = []
            for date in dict {
                dates.append(date.getSince1970String())
            }
            dates = dates.sorted().reversed()
        }
        nextWaterDate = Global.shared.selectedPlant?.getNextWaterDate().getSince1970String() ?? ""
    }

    func setUpCalendar(){
        calendar.today = Date()
        calendar.locale = Locale(identifier: "ko_KR")

        calendarView.layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)

        calendar.daysContainer.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        calendar.daysContainer.layer.masksToBounds = false
        calendar.daysContainer.layer.shadowColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        calendar.daysContainer.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
        calendar.daysContainer.layer.shadowOpacity = 1.0
        calendar.daysContainer.layer.shadowRadius = 0.0

        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
    }

    // MARK:- FSCalendarDataSource
    public func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateStr = date.timeIntervalSince1970.getSince1970String()
        
        if first {
            calendar.drawDottedLine(start: CGPoint(x: calendar.bounds.minX, y: calendar.bounds.maxY), end: CGPoint(x: calendar.frame.maxX, y: calendar.bounds.maxY), view: calendar)
            first = false
        }
        
        if dates.contains(dateStr) {
            return Color.greenCalendar
        } else if nextWaterDate == dateStr {
            return Color.blueCalendar
        }
        
        return nil
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        if cell.dateIsToday {
            cell.titleLabel.font = UIFont(name: "Baskerville-Bold", size: 14)
        } else {
            cell.titleLabel.font = UIFont(name: "Baskerville", size: 14)
        }
    }
}
