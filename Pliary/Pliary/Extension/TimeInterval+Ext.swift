//
//  TimeInterval+Ext.swift
//  Pliary
//
//  Created by jeewoong.han on 19/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import Foundation

extension Double {
    func getSince1970String() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd"

        let date = Date.init(timeIntervalSince1970: self)
        let dateString = dateFormatter.string(from: date)

        return dateString
    }

    func getSince1970LongString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"

        let date = Date.init(timeIntervalSince1970: self)
        let dateString = dateFormatter.string(from: date)

        return dateString
    }
    
    func getSince1970StringForCalendar() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"

        let date = Date.init(timeIntervalSince1970: self)
        let dateString = dateFormatter.string(from: date)

        return dateString
    }
    
    func getMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        
        let date = Date.init(timeIntervalSince1970: self)
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}

extension Date {
    func getDayStartTime() -> TimeInterval {
        return Calendar.current.startOfDay(for: self).timeIntervalSince1970
    }
}
