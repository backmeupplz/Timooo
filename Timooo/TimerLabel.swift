//
//  TimerLabel.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 24/02/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class TimerLabel: UILabel {
    
    // MARK: - View Life Cycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fixLabelAutoshrink()
        setupNotifications()
    }
    
    // MARK: - General Methods -
    
    func fixLabelAutoshrink() {
        adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Notifications -
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedTimeNotification:", name: didChangeTimeNotification, object: nil)
    }
    
    func receivedTimeNotification(notification: NSNotification) {
        text = notification.userInfo![newValueKey] as? String
    }
}