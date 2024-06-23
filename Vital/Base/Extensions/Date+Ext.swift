//
//  Date+Ext.swift
//  Vital
//
//  Created by Tyler Rhodes on 5/19/24.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    var weekdayTitle: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    
    var displayFormat: String {
        self.formatted(date: .long, time: .omitted)
    }
    
    var timeFormat: String {
        self.formatted(
            .dateTime
                .year(.defaultDigits)
                .month(.wide)
                .day(.twoDigits)
                .hour()
                .minute()
        )
    }
}
