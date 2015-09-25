//
//  ContainerViewController.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 15/09/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import UIKit

class ContainerViewController: LGSideMenuController {
    
    // MARK: - Variables -
    
    var sideViewController: UIViewController!
    
    // MARK: - VC Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
    }

    // MARK: - General Functions -
    
    func setupSideMenu() {
        setRootViewController(storyboard!.instantiateViewControllerWithIdentifier("MainViewController") as! UIViewController)
        sideViewController = storyboard!.instantiateViewControllerWithIdentifier("SideViewController") as! UIViewController
        
        setLeftViewEnabledWithWidth(CGFloat(260), presentationStyle: LGSideMenuPresentationStyleSlideBelow, alwaysVisibleOptions: LGSideMenuAlwaysVisibleOnNone)
        leftView().addSubview(sideViewController.view)
    }
}
