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
            checkState()
            setNeedsDisplay()
        }
    }
    var percent: Float? {
        didSet {
            setNeedsDisplay()
        }
    }
    var reverse: Bool? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Object Life Cycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        maskView = getTomatoImageView()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if (tomatoState == .Running) {
            makeCircle()
        }
    }
    
    // MARK: - General Methods -
    
    func getTomatoImageView() -> UIImageView {
        let tomatoImageView = UIImageView(frame: bounds)
        tomatoImageView.image = UIImage(named: "icon_tomato")
        return tomatoImageView
    }
    
    func checkState() {
        switch tomatoState! {
        case .Running:
            backgroundColor = UIColor(white:1.0, alpha:0.7)
            setupRunning()
        case .Finished:
            backgroundColor = UIColor(white:0.0, alpha:0.7)
        default:
            backgroundColor = UIColor(white:1.0, alpha:0.7)
        }
    }
    
    func makeCircle() {
        var startPoint: CGFloat?
        var endPoint: CGFloat?
        if (!reverse!) {
            startPoint = CGFloat(-M_PI_2)
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
    
    func setupRunning() {
        percent = 0.0
        reverse = false
    }
}