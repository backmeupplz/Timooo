//
//  TomatoButtonView.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 02/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class TomatoView: UIView {
    var tomatoButtons: [TomatoButton]!
    var currentTomato: Int = 0 {
        didSet {
            self.changedCurrentTomato()
        }
    }
    
    func changedCurrentTomato() {
        for index in 0...currentTomato {
            tomatoButtons[index].tomatoState = .Finished
        }
        tomatoButtons[currentTomato].tomatoState = .Running
        
        if (currentTomato != tomatoButtons.count-1) {
            for index in currentTomato+1...tomatoButtons.count-1 {
                tomatoButtons[index].tomatoState = .Fresh
            }
        }
    }
}
