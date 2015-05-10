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
        self.setupGoogleAnalytics()
        
        return true
    }
    
    // MARK: - General Methods -
    
    func setupGoogleAnalytics() {
        GAI.sharedInstance().trackerWithTrackingId("UA-43367175-5")
    }
}

