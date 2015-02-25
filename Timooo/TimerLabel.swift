//
//  TimerLabel.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 24/02/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class TimerLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.baselineAdjustment = .AlignCenters
        self.adjustsFontSizeToFitWidth = true
    }
}
