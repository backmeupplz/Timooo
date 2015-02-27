//
//  TomatoButton.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 26/02/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

enum TomatoState {
    case Running
    case Finished
    case Fresh
}

class TomatoButton: UIButton {
    var tomatoState: TomatoState? {
        didSet {
            checkColor()
            setNeedsLayout()
        }
    }
    var percent: Float? {
        didSet {
            setNeedsLayout()
        }
    }
    var reverse: Bool? {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        maskView = getTomatoImageView()
        tomatoState = .Running
        percent = 50.0
        reverse = false
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if (tomatoState == .Running) {
            makeCircle()
        }
    }
    
    func getTomatoImageView() -> UIImageView {
        let tomatoImageView = UIImageView(frame: bounds)
        tomatoImageView.image = UIImage(named: "icon_tomato")
        return tomatoImageView
    }
    
    func checkColor() {
        switch tomatoState! {
        case .Running:
            backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        case .Finished:
            backgroundColor = UIColor.blackColor()
        default:
            backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        }
    }
    
    func makeCircle() {
        var startPoint: CGFloat?
        var endPoint: CGFloat?
        if (!self.reverse!) {
            startPoint = CGFloat(3.0 * M_PI_2)
            endPoint = CGFloat(2 * M_PI) * CGFloat(percent!/100.0) - CGFloat(M_PI_2)
        } else {
            startPoint = CGFloat(2.0 * M_PI) * CGFloat(percent!/100.0) - CGFloat(M_PI_2)
            endPoint = -CGFloat(M_PI_2)
        }
        
        let radius = CGFloat(frame.size.width/2)
        let center = CGPointMake(radius,radius)
        let arc = UIBezierPath()
        arc.moveToPoint(center)
        var next = CGPoint()
        next.x = center.x + radius * cos(startPoint!);
        next.y = center.y + radius * sin(startPoint!);
        
        arc.addLineToPoint(next)
        arc.addArcWithCenter(center, radius: radius, startAngle: startPoint!, endAngle: endPoint!, clockwise: true)
        arc.addLineToPoint(center)
        
        UIColor.redColor().set()
        
        arc.fill()
    }
}