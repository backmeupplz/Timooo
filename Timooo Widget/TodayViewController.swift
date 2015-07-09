//
//  TodayViewController.swift
//  Timooo Widget
//
//  Created by Nikita Kolmogorov on 06/07/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import UIKit
import NotificationCenter

let didChangeTimeNotification = "didChangeTimeNotification"
let newValueKey = "newValueKey"

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - Variables -
    
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.Nikita-Kolmogorov.Po-Pomodoro.")!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Extention lyfe cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
    }
    
    // MARK: - General Methods -
    
    func setupNotifications() {
        defaults.addObserver(self, forKeyPath: "timerText", options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        
        if (keyPath == "timerText") {
            timerLabel.text = change[NSKeyValueChangeNewKey] as? String
        }
    }
}
