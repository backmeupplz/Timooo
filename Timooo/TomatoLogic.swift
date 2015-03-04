//
//  TomatoLogic.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 02/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

let _sharedInstanceTomatoLogic = TomatoLogic()

let didChangePercentNotification = "didChangePercentNotification"
let didChangeCurrentTomatoNotification = "didChangeCurrentTomatoNotification"
let didChangeReverseNotification = "didChangeReverseNotification"
let didChangeTimeNotification = "didChangeTimeNotification"
let newValueKey = "newValueKey"

class TomatoLogic: NSObject {
    class var sharedInstance: TomatoLogic {
        return _sharedInstanceTomatoLogic
    }
    var percent: Float = 0.0 {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangePercentNotification, object: nil, userInfo:[newValueKey:percent])
        }
    }
    var currentTomato: Int = 0 {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangeCurrentTomatoNotification, object: nil, userInfo:[newValueKey:currentTomato])
            percent = 0.0
            reverse = false
            timeString = "0:00"
        }
    }
    
    var reverse: Bool = false {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangeReverseNotification, object: nil, userInfo:[newValueKey:reverse])
        }
    }
    var timeString: String = "0:00" {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangeTimeNotification, object: nil, userInfo:[newValueKey:timeString])
        }
    }
    var timer = NSTimer()
    
    func stop() {
        println("STOP")
    }
    
    func pause() {
        println("PAUSE")
        timer.invalidate()
    }
    
    func play() {
        println("PLAY")
        if (!timer.valid) {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1,
                target: TomatoLogic.sharedInstance,
                selector: Selector("tick"),
                userInfo: nil,
                repeats: true)
        }
    }
    
    func next() {
        println("NEXT")
    }
    
    func tick() {
        println("tick")
    }
}