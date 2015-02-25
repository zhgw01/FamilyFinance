//
//  DateUtil.swift
//  FamilyFinance
//
//  Created by Gongwei on 15/2/25.
//  Copyright (c) 2015年 Zhang Gongwei. All rights reserved.
//

import Foundation

class DateUtil {
    class func getMonth(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        return calendar.component(NSCalendarUnit.MonthCalendarUnit, fromDate: date) - 1
    }
    
    class func getCurrentMonth() -> Int {
        return getMonth(NSDate())
    }
}