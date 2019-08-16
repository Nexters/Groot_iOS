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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        calendar.delegate = self
        calendar.dataSource = self
        
        setUpCalendar()
        loadDates()
    }
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate let formatterForCell: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    
    var dates = [Date]()
    
    
    private func loadDates() {
        let date1 = Date(timeIntervalSince1970: 1564588800)
        let date2 = Date(timeIntervalSince1970: 1564761600)
        let date3 = Date(timeIntervalSince1970: 1565020800)
        dates += [date1, date2, date3]
    }
    
    func setUpCalendar(){
    
        calendar.today = nil
        calendar.locale = Locale(identifier: "ko_KR")
        
        calendarView.layer.applySketchShadow( color: #colorLiteral(red: 0.3490196078, green: 0.3529411765, blue: 0.4235294118, alpha: 0.08), alpha: 0.8, x: 0, y: 9, blur: 15, spread: 0)
        
        calendar.daysContainer.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        calendar.daysContainer.layer.masksToBounds = false
        calendar.daysContainer.layer.shadowColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        calendar.daysContainer.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
        calendar.daysContainer.layer.shadowOpacity = 1.0
        calendar.daysContainer.layer.shadowRadius = 0.0
        
        calendar.allowsMultipleSelection = true
        calendar.appearance.selectionColor = #colorLiteral(red: 0.5058823529, green: 0.8, blue: 0.537254902, alpha: 1)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
    }
    
//    // MARK:- FSCalendarDataSource
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//
//        let day: Int! = self.gregorian.component(.day, from: date)
//        return day % 5 == 0 ? day/5 : 0;
//    }

    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return self.gregorian.isDateInToday(date) ? UIImage(named: "TodayLine") : nil
    }
    
    // MARK:- FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.formatter.string(from: calendar.currentPage))")
    }
}
