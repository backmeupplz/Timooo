//
//  TodayExtensionManager.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 06/07/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

private let _sharedInstanceTodayExtensionManager = TodayExtensionManager()

class TodayExtensionManager {
    
    // MARK: - Variables -
    
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.Nikita-Kolmogorov.Po-Pomodoro.")!
    
    // MARK: - Singleton -
    
    class var sharedInstance: TodayExtensionManager {
        return _sharedInstanceTodayExtensionManager
    }
    
    // MARK: - Object Life Cycle -
    
    init() {
        setupNotifications()
    }
    
    // MARK: - General Methods -
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedTimeNotification:", name: didChangeTimeNotification, object: nil)
    }
    
    func receivedTimeNotification(notification: NSNotification) {
        var text = notification.userInfo![newValueKey] as? String
        
        defaults.setObject(text, forKey: "timerText")
    }
}