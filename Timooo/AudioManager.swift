//
//  AudioManager.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 02/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation
import AVFoundation

private let _sharedInstanceAudioManager = AudioManager()

class AudioManager {
    // TODO: Memorize position between sessions
    var enabled: Bool = true
    var audioPlayer: AVAudioPlayer!
    
    class var sharedInstance: AudioManager {
        return _sharedInstanceAudioManager
    }
    
    // MARK: - Object Life Cycle -
    
    init() {
        let soundURL = NSBundle.mainBundle().URLForResource("sound", withExtension: "wav")
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        audioPlayer.prepareToPlay()
        enabled = MemoryManager.sharedInstance.getAudioManagerState()
    }
    
    // MARK: - General Methods -
    
    func playTimerBeep() {
        if (enabled) {
            audioPlayer.play()
        }
    }
}