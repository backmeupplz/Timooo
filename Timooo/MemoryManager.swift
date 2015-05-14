//
//  MemoryManager.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 13/05/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

private let _sharedInstanceMemoryManager = MemoryManager()

class MemoryManager {
    
    // MARK: - Singleton -
    
    class var sharedInstance: MemoryManager {
        return _sharedInstanceMemoryManager
    }
    
    // MARK: - Public Methods -
    
    func addTomato() {
        
    }
    
    func getHistory() -> [HistoryObject] {
        return []
    }
    
    func deleteTomato(tomato: HistoryObject) {
        
    }
}