//
//  AppDelegate.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 23/02/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - App Life Cycle -
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.idleTimerDisabled = true
        registerForNotifications(application)
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        setupAppirater()
        
        return true
    }
    
    func applicationWillTerminate(application: UIApplication) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        print("App got terminated");
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        Appirater.appEnteredForeground(true)
    }
    
    // MARK: - General Methods -
    
    func setupAppirater() {
        Appirater.setAppId("775844265")
        Appirater.appLaunched(true)
        Appirater.setUsesUntilPrompt(5)
    }
    
    func registerForNotifications(application: UIApplication) {
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Alert, UIUserNotificationType.Badge], categories: nil))
    }
}

