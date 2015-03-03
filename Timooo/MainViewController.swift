//
//  ViewController.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 23/02/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tomatoView: TomatoView!
    @IBOutlet var tomatoButtons: [TomatoButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tomatoView.tomatoButtons = tomatoButtons
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func toggleSound(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    @IBAction func selectTomato(sender: UIButton) {
        tomatoView.currentTomato = sender.tag
    }
    
}

