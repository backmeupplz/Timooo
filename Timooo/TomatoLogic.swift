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
    
    // MARK: - Public Variables -
    
    var percent: Float = 0.0 {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangePercentNotification, object: nil, userInfo:[newValueKey:percent])
        }
    }
    var currentTomato: Int = 0 {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(didChangeCurrentTomatoNotification, object: nil, userInfo:[newValueKey:currentTomato])
            reverse = false
            timeString = "0:00"
            self.updatePercentage()
        }
    }
    
    // MARK: - Private Variables -
    
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
        println("tick")
        
        self.incrementTimeString()
        self.checkTimeString()
        self.updatePercentage()
    }
    
    // MARK: - Public Methods -
    
    func setPercentage(perc: Float) {
        self.percent = perc
        self.updateTimeString()
    }
    
    func stop() {
        println("STOP")
    }
    
    func pause() {
        println("PAUSE")
        self.stopTimer()
    }
    
    func play() {
        println("PLAY")
        self.startTimer()
    }
    
    func next() {
        println("NEXT")
    }
    
    // MARK: - General Methods -
    
    func updatePercentage() {
        let maxSeconds = self.getCurrentMaxSeconds()
        let currentSeconds = self.convertTimeStringToSeconds(self.timeString)
        
        self.percent = (Float(currentSeconds)/Float(maxSeconds))*100.0
    }
    
    func updateTimeString() {
        let maxSeconds = Float(self.getCurrentMaxSeconds())
        self.timeString = self.convertSecondsToTimeString(Int(maxSeconds*(self.percent/100.0)))
    }
    
    func getCurrentMaxSeconds() -> Int {
        if (self.reverse) {
            if (self.currentTomato == 3) {
                return 30*60
            } else {
                return 5*60
            }
        } else {
            return 25*60
        }
    }
    
    func incrementTimeString() {
        var seconds = self.convertTimeStringToSeconds(self.timeString)
        seconds++
        self.timeString = self.convertSecondsToTimeString(seconds)
    }
    
    func checkTimeString() {
        let currentSeconds = self.convertTimeStringToSeconds(self.timeString)
        let maxSeconds = self.getCurrentMaxSeconds()
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
    
    func convertTimeStringToSeconds(timeString: String) -> Int {
        let tokens = timeString.componentsSeparatedByString(":")
        let minutes = tokens[0].toInt()
        let seconds = tokens[1].toInt()
        return (minutes!*60) + seconds!
    }
}