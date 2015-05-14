//
//  TimerSlider.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 02/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class TimerSlider: UISlider {
    
    // MARK: - View Life Cycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupNotifications()
    }
    
    // MARK: - Notifications -
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedPercentNotification:", name: didChangePercentNotification, object: nil)
    }
    
    func receivedPercentNotification(notification: NSNotification) {
        value = notification.userInfo![newValueKey] as! Float
    }
}
