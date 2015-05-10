//
//  TomatoButtonView.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 02/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class TomatoView: UIView {
    var tomatoButtons: [TomatoButton]!
    var currentTomato: Int = 0 {
        didSet {
            self.changedCurrentTomato()
        }
    }
    var reverse: Bool = false {
        didSet {
            tomatoButtons[currentTomato].reverse = reverse
        }
    }
    var percent: Float = 0.0 {
        didSet {
            tomatoButtons[currentTomato].percent = percent
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedPercentNotification:", name: didChangePercentNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedReverseNotification:", name: didChangeReverseNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedCurrentTomatoNotification:", name: didChangeCurrentTomatoNotification, object: nil)
    }
    
    func changedCurrentTomato() {
        for index in 0...currentTomato {
            tomatoButtons[index].tomatoState = .Finished
        }
        tomatoButtons[currentTomato].tomatoState = .Running
        if (currentTomato != tomatoButtons.count-1) {
            for index in currentTomato+1...tomatoButtons.count-1 {
                tomatoButtons[index].tomatoState = .Fresh
            }
        }
    }
    
    func receivedPercentNotification(notification: NSNotification) {
        self.percent = notification.userInfo![newValueKey] as! Float
    }
    
    func receivedReverseNotification(notification: NSNotification) {
        self.reverse = notification.userInfo![newValueKey] as! Bool
    }
    
    func receivedCurrentTomatoNotification(notification: NSNotification) {
        self.currentTomato = notification.userInfo![newValueKey] as! Int
    }
}
