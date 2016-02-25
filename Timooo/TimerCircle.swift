//
//  TimerCircle.swift
//  Timooo
//
//  Created by Nikita Kolmogorov on 24/02/15.
//  Copyright (c) 2015 Borodutch Studio LLC. All rights reserved.
//

import Foundation

let lineWidth: CGFloat = 10.0

class TimerCircle: UIView {
    var percent: Float = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var reverse: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    var color: UIColor!
    
    // MARK: - View Life Cycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupColors()
        setupNotifications()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        drawCircles()
    }
    
    // MARK: - General Methods -
    
    func setupColors() {
        color = backgroundColor
        backgroundColor = UIColor.clearColor()
    }
    
    func drawCircles() {
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        CGContextSetLineWidth(context, lineWidth);
        CGContextBeginPath(context);
        
        let x: CGFloat = frame.size.width/2.0
        let y: CGFloat = frame.size.height/2.0
        let radius: CGFloat = frame.size.width/2.0-lineWidth/2.0
        let startAngle: CGFloat = 0.0
        let endAngle: CGFloat = CGFloat(2.0*M_PI)
        
        CGContextAddArc(context, x, y, radius, startAngle, endAngle, 0);
        CGContextClosePath(context);
        
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextDrawPath(context, CGPathDrawingMode.Stroke);
        
        CGContextSetLineWidth(context, lineWidth/2);
        CGContextBeginPath(context);
        
        var start: CGFloat!
        var end: CGFloat!
        
        if (!reverse) {
            start = CGFloat(-M_PI_2)
            end = CGFloat(2 * M_PI) * CGFloat(percent/100.0) - CGFloat(M_PI_2)
        } else {
            start = CGFloat(2.0 * M_PI) * CGFloat(percent/100.0) - CGFloat(M_PI_2)
            end = -CGFloat(M_PI_2)
        }
        
        CGContextAddArc(context, x, y, radius, start, end, 0);
        
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor);
        CGContextDrawPath(context, CGPathDrawingMode.Stroke);
    }
    
    // MARK: - Notifications -
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedPercentNotification:", name: didChangePercentNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedReverseNotification:", name: didChangeReverseNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"deviceOrientationDidChangeNotification:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func receivedPercentNotification(notification: NSNotification) {
        percent = notification.userInfo![newValueKey] as! Float
    }
    
    func receivedReverseNotification(notification: NSNotification) {
        reverse = notification.userInfo![newValueKey] as! Bool
    }
    
    func deviceOrientationDidChangeNotification(notification: NSNotification) {
        setNeedsDisplay()
    }
}