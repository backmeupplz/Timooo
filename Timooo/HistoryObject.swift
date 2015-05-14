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
        coder.encodeObject(tomatosCount, forKey: "tomatosCount")
        coder.encodeObject(date, forKey: "date")
    }
}