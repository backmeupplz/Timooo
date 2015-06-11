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
    
    // MARK: - Singleton -
    
    class var sharedInstance: TomatoLogic {
        return _sharedInstanceTomatoLogic
    }
    
    override init() {
        super.init()
        resetSecondsLeft()
    }
    
    // MARK: - Public Variables -
    
    var currentTomato = 0 {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangeCurrentTomatoNotification, object: nil, userInfo:[newValueKey:currentTomato])
            reverse = false
            resetSecondsLeft()
        }
    }
    
    // MARK: - Private Variables -
    
    var secondsLeft = 0 {
        didSet {
            updateTimeString()
            updatePercentage()
        }
    }
    var percent: Float = 0.0 {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangePercentNotification, object: nil, userInfo:[newValueKey:percent])
        }
    }
    var reverse = false {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangeReverseNotification, object: nil, userInfo:[newValueKey:reverse])
        }
    }
    var timeString = "0:00" {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangeTimeNotification, object: nil, userInfo:[newValueKey:timeString])
        }
    }
    
    // MARK: - Timers -
    
    var timer = NSTimer()
    
    func startTimer() {
        if (!timer.valid) {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01,
                target: TomatoLogic.sharedInstance,
                selector: Selector("tick"),
                userInfo: nil,
                repeats: true)
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func tick() {
        secondsLeft--
        if (secondsLeft < 0) {
            nextCycle()
            if (reverse) {
                MemoryManager.sharedInstance.addTomato()
            }
        }
    }
    
    // MARK: - Public Methods -
    
    func setProgress(progress: Float) {
        let maxSeconds = Float(getCurrentMaxSeconds())
        secondsLeft = Int(maxSeconds) - Int(maxSeconds * progress / 100.0)
    }
    
    func stop() {
        resetSecondsLeft()
    }
    
    func pause() {
        stopTimer()
    }
    
    func play() {
        startTimer()
    }
    
    func next() {
        nextCycle()
    }
    
    // MARK: - General Methods -
    
    func nextCycle() {
        if (!reverse) {
            reverse = true
            resetSecondsLeft()
        } else {
            if (currentTomato >= 3) {
                currentTomato = 0
            } else {
                currentTomato++
            }
        }
        AudioManager.sharedInstance.playTimerBeep()
    }
    
    func resetSecondsLeft() {
        secondsLeft = getCurrentMaxSeconds()
    }
    
    func updatePercentage() {
        let maxSeconds = Float(getCurrentMaxSeconds())
        let currentSeconds = maxSeconds - Float(secondsLeft)
        percent = currentSeconds/maxSeconds*100.0
    }
    
    func updateTimeString() {
        timeString = convertSecondsToTimeString(secondsLeft)
    }
    
    func getCurrentMaxSeconds() -> Int {
        if (reverse) {
            if (currentTomato == 3) {
                return 30*60
            } else {
                return 5*60
            }
        } else {
            return 25*60
        }
    }
    
    func convertSecondsToTimeString(totalSeconds: Int) -> String {
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        let hours = totalSeconds / 3600
        let strHours = hours > 9 ? String(hours) : "0" + String(hours)
        let strMinutes = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds) : "0" + String(seconds)
        
        if hours > 0 {
            return "\(strHours):\(strMinutes):\(strSeconds)"
        }
        else {
            return "\(strMinutes):\(strSeconds)"
        }
    }
}