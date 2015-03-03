//
//  TomatoLogic.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 02/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

let _sharedInstance = TomatoLogic()

let didChangePercentNotification = "didChangePercentNotification"
let didChangeCurrentTomatoNotification = "didChangeCurrentTomatoNotification"
let didChangeReverseNotification = "didChangeReverseNotification"
let didChangeTimeNotification = "didChangeTimeNotification"
let newValueKey = "newValueKey"

class TomatoLogic {
    class var sharedInstance: TomatoLogic {
        return _sharedInstance
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
    
    func stop() {
        println("STOP")
    }
    
    func pause() {
        println("PAUSE")
    }
    
    func play() {
        println("PLAY")
    }
    
    func next() {
        println("NEXT")
    }
}