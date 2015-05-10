//
//  File.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 03/03/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

class TomatoCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var tomatoImages: [UIImageView]!
    @IBOutlet weak var multiplierLabel: UILabel!
    
    var object: HistoryObject! {
        didSet {
            configure()
        }
    }
    
    // MARK: - General Methods -
    
    func configure() {
        self.layoutMargins = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        
        if (object.tomatosCount > 5) {
            for i in 1...4 {
                tomatoImages[i].hidden = true
            }
            multiplierLabel.hidden = false
            multiplierLabel.text = "x\(object.tomatosCount)"
        } else {
            for i in 0...object.tomatosCount-1 {
                tomatoImages[i].hidden = false
            }
            multiplierLabel.hidden = true
        }
        dateLabel.text = object.dateSring
    }
}
