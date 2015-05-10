//
//  HistoryObject.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 03/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class HistoryObject {
    var tomatosCount = 0
    var date: NSDate!
    var dateSring: String {
        get {
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            return formatter.stringFromDate(date)
        }
    }
    
    // MARK: - General Methods -
    
    func setDate(year: Int, month: Int, day: Int) {
        var dateComps = NSDateComponents()
        dateComps.year = year
        dateComps.month = month
        dateComps.day = day
        date = NSCalendar.currentCalendar().dateFromComponents(dateComps)!
    }
}