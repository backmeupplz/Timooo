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
            self.setNeedsDisplay()
        }
    }
    var reverse: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var color: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.color = self.backgroundColor
        self.backgroundColor = UIColor.clearColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedPercentNotification:", name: didChangePercentNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedReverseNotification:", name: didChangeReverseNotification, object: nil)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.drawCircles()
    }
    
    func drawCircles() {
        var context: CGContextRef = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, lineWidth);
        CGContextBeginPath(context);
        
        let x: CGFloat = self.frame.size.width/2.0
        let y: CGFloat = self.frame.size.height/2.0
        let radius: CGFloat = self.frame.size.width/2.0-lineWidth/2.0
        let startAngle: CGFloat = 0.0
        let endAngle: CGFloat = CGFloat(2.0*M_PI)
        
        CGContextAddArc(context, x, y, radius, startAngle, endAngle, 0);
        CGContextClosePath(context);
        
        CGContextSetStrokeColorWithColor(context, self.color!.CGColor);
        CGContextDrawPath(context, kCGPathStroke);
        
        CGContextSetLineWidth(context, lineWidth/2);
        CGContextBeginPath(context);
        
        var start: CGFloat?
        var end: CGFloat?
        
        if (!self.reverse) {
            start = CGFloat(3.0 * M_PI_2)
            end = CGFloat(2 * M_PI) * CGFloat(self.percent/100.0) - CGFloat(M_PI_2)
        } else {
            start = CGFloat(2.0 * M_PI) * CGFloat(self.percent/100.0) - CGFloat(M_PI_2)
            end = -CGFloat(M_PI_2)
        }
        
        CGContextAddArc(context, x, y, radius, start!, end!, 0);
        
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    func receivedPercentNotification(notification: NSNotification) {
        self.percent = notification.userInfo![newValueKey] as! Float
    }
    
    func receivedReverseNotification(notification: NSNotification) {
        self.reverse = notification.userInfo![newValueKey] as! Bool
    }
}