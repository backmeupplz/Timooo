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
let UDTimerTimestamp = "UDTimerTimestamp"

let workPeriod = 25*60
let restPeriod = 5*60
let longRestPeriod = 30*60

class TomatoLogic: NSObject {
    
    // MARK: - Singleton -
    
    class var sharedInstance: TomatoLogic {
        return _sharedInstanceTomatoLogic
    }
    
    override init() {
        super.init()
        resetSecondsLeft()
        setupNotifications()
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
            timer = NSTimer.scheduledTimerWithTimeInterval(1,
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
    
    // MARK: - Notifications -
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("appDidEnterBackground:"), name:UIApplicationDidEnterBackgroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("appDidBecomeActive:"), name:UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func appDidEnterBackground(notification : NSNotification) {
        print("appDidEnterBackground method called")
        saveTimers()
        scheduleLocalNotifications()
    }
    
    func appDidBecomeActive(notification : NSNotification) {
        print("appDidBecomeActive method called")
        restoreTimers()
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
                return longRestPeriod
            } else {
                return restPeriod
            }
        } else {
            return workPeriod
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
    
    // MARK: - Background -
    
    func saveTimers() {
        NSUserDefaults.standardUserDefaults().setObject(NSDate().timeIntervalSince1970, forKey: UDTimerTimestamp)
    }
    
    func restoreTimers() {
        if (timer.valid) {
            let timestampObject: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(UDTimerTimestamp)
            if (timestampObject == nil) {
                return
            }
            var interval = Int(NSDate().timeIntervalSince1970) - timestampObject!.integerValue!
            
            let tempAudio = AudioManager.sharedInstance.enabled
            AudioManager.sharedInstance.enabled = false
            
            while (interval > 0) {
                if (interval > secondsLeft) {
                    interval -= secondsLeft
                    next()
                } else {
                    secondsLeft -= interval
                    interval = 0
                }
            }
            
            AudioManager.sharedInstance.enabled = tempAudio
        }
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: UDTimerTimestamp)
    }
    
    func scheduleLocalNotifications() {
        if (timer.valid) {
            print("scheduleLocalNotifications method called")
            
            var seconds = secondsLeft
            var toma = currentTomato
            var rev = reverse
            
            for _ in 0...39 {
                
                if (!rev) {
                    if (toma != 3) {
                        scheduleRestNotification(seconds)
                        seconds += restPeriod
                        rev = true
                    } else {
                        scheduleRestNotification(seconds)
                        seconds += longRestPeriod
                        rev = true
                    }
                } else {
                    scheduleWorkNotification(seconds)
                    seconds += workPeriod
                    rev = false
                    toma++
                    if toma > 3 {
                        toma = 0
                    }
                }
            }
        }
    }
    
    func scheduleWorkNotification(delay: Int) {
        let notification = UILocalNotification()
        notification.alertBody = NSLocalizedString("It's time to work!", comment: "")
        notification.fireDate = NSDate(timeIntervalSince1970: NSDate().timeIntervalSince1970 + NSTimeInterval(delay))
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func scheduleRestNotification(delay: Int) {
        let notification = UILocalNotification()
        notification.alertBody = NSLocalizedString("Great work! Time to have a rest!", comment: "")
        notification.fireDate = NSDate(timeIntervalSince1970: NSDate().timeIntervalSince1970 + NSTimeInterval(delay))
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}