//
//  MemoryManager.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 13/05/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

let didAddTomato = "didAddTomato"
let didUpdateTomato = "didUpdateTomato"
let UDHistory = "UDHistory"

private let _sharedInstanceMemoryManager = MemoryManager()

class MemoryManager {
    
    // MARK: - Singleton -
    
    class var sharedInstance: MemoryManager {
        return _sharedInstanceMemoryManager
    }
    
    // MARK: - Public Methods -
    
    func addTomato() {
        let date = getTodayDate()
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let data = defaults.objectForKey(UDHistory) as? NSData
        
        if (data != nil) {
            
            var array = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [HistoryObject]
            if (array.count > 0) {
                var lastObject: HistoryObject! = array.last
                
                if (lastObject.date.isEqualToDate(date)) {
                    lastObject.tomatosCount++
                    defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(array), forKey:UDHistory)
                    postUpdateTomatoNotifcation()
                } else {
                    var object = HistoryObject()
                    object.date = date
                    object.tomatosCount = 1
                    array.append(object)
                    defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(array), forKey:UDHistory)
                    postAddTomatoNotifcation(object)
                }
            } else {
                var object = HistoryObject()
                object.date = date
                object.tomatosCount = 1
                array.append(object)
                defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(array), forKey:UDHistory)
                postAddTomatoNotifcation(object)
            }
        } else {
            
            var array = [HistoryObject]()
            var object = HistoryObject()
            object.date = date
            object.tomatosCount = 1
            array.append(object)
            
            defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(array), forKey:UDHistory)
            
            postAddTomatoNotifcation(object)
        }
    }
    
    func getHistory() -> [HistoryObject] {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let data = defaults.objectForKey(UDHistory) as? NSData
        
        if (data != nil) {
            let array = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [HistoryObject]
            
            return array
        } else {
            
            return [HistoryObject]()
        }
    }
    
    func deleteTomato(index: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let data = defaults.objectForKey(UDHistory) as? NSData {
            var array = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [HistoryObject]
            array.removeAtIndex(index)
            defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(array), forKey:UDHistory)
        }
    }
    
    // MARK: - General Methods -
    
    func getTodayDate() -> NSDate {
        var cal = NSCalendar.currentCalendar()
        var date = NSDate()
        var comps = cal.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate:date)
        return cal.dateFromComponents(comps)!
    }
    
    // MARK: - Notifications -
    
    func postAddTomatoNotifcation(object: HistoryObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(didAddTomato, object:nil, userInfo:[newValueKey:object])
    }
    
    func postUpdateTomatoNotifcation() {
        NSNotificationCenter.defaultCenter().postNotificationName(didUpdateTomato, object:nil, userInfo:nil)
    }
}