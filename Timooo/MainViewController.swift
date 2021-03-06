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
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    // MARK: - VC Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        setupAudioButton()
    }
    
    // MARK: - IB Actions -
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        
        (UIApplication.sharedApplication().delegate?.window??.rootViewController as? ContainerViewController)?.showLeftViewAnimated(true, completionHandler: nil)
        
        (UIApplication.sharedApplication().delegate?.window??.rootViewController as? ContainerViewController)?.hideLeftViewAnimated(true, completionHandler: nil)
    }
    
    @IBAction func toggleSound(sender: UIButton) {
        AudioManager.sharedInstance.enabled = sender.selected
        sender.selected = !sender.selected
        MemoryManager.sharedInstance.setAudioManagerState(!sender.selected)
    }
    
    @IBAction func selectTomato(sender: UIButton) {
        TomatoLogic.sharedInstance.currentTomato = sender.tag
    }
    
    @IBAction func changePercent(sender: UISlider) {
        TomatoLogic.sharedInstance.setProgress(sender.value)
    }

    @IBAction func stopTimer(sender: AnyObject) {
        TomatoLogic.sharedInstance.stop()
    }

    @IBAction func playTimer(sender: AnyObject) {
        pauseButton.hidden = false
        playButton.hidden = true
        TomatoLogic.sharedInstance.play()
    }
    
    @IBAction func pauseTimer(sender: AnyObject) {
        pauseButton.hidden = true
        playButton.hidden = false
        TomatoLogic.sharedInstance.pause()
    }
    
    @IBAction func nextTimer(sender: AnyObject) {
        TomatoLogic.sharedInstance.next()
    }
    
    // MARK: - General Methods -
    
    func setupGestures() {
//        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
//        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    func setupAudioButton() {
        audioButton.selected = !MemoryManager.sharedInstance.getAudioManagerState()
    }
}

