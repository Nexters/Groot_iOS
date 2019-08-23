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
    var plant : Plant? = nil

    var dates = [String]()
    var datesTodo = [String]()
    var dateList = [Int]()

    static func instance() -> CalendarTableViewCell {
        let view: CalendarTableViewCell = UIView.createViewFromNib(nibName: CalendarTableViewCell.identifier)
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        loadDates()
        loadDatesTodo()
        
        calendar.delegate = self
        calendar.dataSource = self
        setUpCalendar()
    }
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    private func loadDates() {
        
        let plant = Global.shared.selectedPlant
        guard let waterDates = plant?.waterDates.split(separator: "|") else { return }
        for date in waterDates {
            dates.append(String(date))
        }
        let date = Date(timeIntervalSince1970: TimeInterval(plant?.lastWaterDate ?? 0))
        dates.append(formatter.string(from: date))
    }
    
    private func loadDatesTodo() {
        let plant = Global.shared.selectedPlant
        datesTodo = plant?.getWaterDatesTodo() ?? []
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
    
//    // MARK:- FSCalendarDataSource
    
    public func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        
        if dates.contains(formatter.string(from: date)) {
            return Color.greenCalendar
        } else if datesTodo.contains(formatter.string(from: date)) {
            return Color.blueCalendar
        }
        calendar.drawDottedLine(start: CGPoint(x: calendar.bounds.minX, y: calendar.bounds.maxY), end: CGPoint(x: calendar.frame.maxX, y: calendar.bounds.maxY), view: calendar)
        return nil
    }

    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {

        return self.gregorian.isDateInToday(date) ? UIImage(named: "TodayLine") : nil
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(formatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        if cell.dateIsToday {
            cell.titleLabel.font = UIFont(name: "Baskerville-Bold", size: 14)
        } else {
            cell.titleLabel.font = UIFont(name: "Baskerville", size: 14)
        }
    }
}
