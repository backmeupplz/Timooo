//
//  HistoryObject.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 03/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class HistoryObject: NSObject, NSCoding {
    var tomatosCount = 0
    var date: NSDate!
    var dateSring: String! {
        get {
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            return formatter.stringFromDate(date)
        }
    }
    
    // MARK: - NSCoding -
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.tomatosCount = decoder.decodeObjectForKey("tomatosCount") as! Int
        self.date = decoder.decodeObjectForKey("date") as! NSDate
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.tomatosCount, forKey: "tomatosCount")
        coder.encodeObject(self.date, forKey: "date")
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