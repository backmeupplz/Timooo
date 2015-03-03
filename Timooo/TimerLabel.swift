//
//  TimerLabel.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 24/02/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class TimerLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.baselineAdjustment = .AlignCenters
        self.adjustsFontSizeToFitWidth = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedTimeNotification:", name: didChangeTimeNotification, object: nil)
    }
    
    func receivedTimeNotification(notification: NSNotification) {
        self.text = notification.userInfo![newValueKey] as? String
    }
}
