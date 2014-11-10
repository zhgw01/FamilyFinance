//
//  CircleButton.swift
//  FamilyFinance
//
//  Created by Zhang Gongwei on 11/6/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

import UIKit
import Foundation

class CircleButton: UIButton {

    enum ChartType {
        case Percent
        case Dollar
        case None
    }
    
    var countingLabel: UILabel
    
    var strokeColor: UIColor = PNFreshGreen
    var strokeColorGradientStart: UIColor?
    var total: NSNumber
    var current: NSNumber
    var lineWidth: NSNumber = 8.0
    var duration: NSTimeInterval = 1.0
    var chartType: ChartType = .Percent
    
    var circle: CAShapeLayer
    var circleBG: CAShapeLayer
    
 
    
    init(frame: CGRect, total: NSNumber, current: NSNumber, clockwise: Bool, shadow: Bool) {
        let labelFrame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 50.0)
        self.countingLabel = UILabel(frame: labelFrame)
        self.total = total
        self.current = current
        self.circle = CAShapeLayer()
        self.circleBG = CAShapeLayer()
        super.init(frame: frame)
        
        let startAngle: CGFloat = clockwise ? -90.0 : 270.0
        let endAngle: CGFloat  = clockwise ? -90.01 : 270.1
        let arcCenter  = CGPoint(x: self.center.x, y: self.center.y)
        let radius: CGFloat     = self.frame.size.height / 2.0
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        self.circle.path = circlePath.CGPath;
        self.circle.lineCap = kCALineCapRound
        self.circle.lineWidth = CGFloat(self.lineWidth.floatValue)
        self.circle.fillColor = UIColor.clearColor().CGColor
        self.circle.zPosition = 1
        
        self.circleBG.path = circlePath.CGPath
        self.circleBG.lineCap = kCALineCapRound
        self.circleBG.lineWidth = CGFloat(self.lineWidth.floatValue)
        self.circleBG.fillColor = UIColor.clearColor().CGColor
        self.circleBG.strokeColor = shadow ? PNLightYellow.CGColor : UIColor.clearColor().CGColor
        self.circleBG.strokeEnd = 1.0
        self.circleBG.zPosition = -1
        
        self.layer.addSublayer(self.circle)
        self.layer.addSublayer(self.circleBG)
        
        self.countingLabel.textAlignment = NSTextAlignment.Center
        self.countingLabel.font = UIFont.boldSystemFontOfSize(16.0)
        self.countingLabel.textColor = UIColor.grayColor()
        self.countingLabel.backgroundColor = UIColor.clearColor()
        self.countingLabel.center = self.center
        self.addSubview(self.countingLabel)
    }
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame, total: 100.0, current: 0.0, clockwise: true, shadow: true)
    }

    required init(coder aDecoder: NSCoder) {
        countingLabel            = aDecoder.decodeObjectForKey("countingLabel") as UILabel
        strokeColor              = aDecoder.decodeObjectForKey("strokeColor") as UIColor
        strokeColorGradientStart = aDecoder.decodeObjectForKey("strokeColorGradientStart") as UIColor?
        total                    = aDecoder.decodeObjectForKey("total") as NSNumber
        current                  = aDecoder.decodeObjectForKey("current") as NSNumber
        lineWidth                = aDecoder.decodeObjectForKey("lineWidth") as NSNumber
        duration                 = aDecoder.decodeObjectForKey("duration") as NSTimeInterval
        circle                   = aDecoder.decodeObjectForKey("circle") as CAShapeLayer
        circleBG                 = aDecoder.decodeObjectForKey("circleBG") as CAShapeLayer
        
        super.init(coder: aDecoder)
        
        self.layer.addSublayer(circle)
        self.layer.addSublayer(circleBG)
        
        self.addSubview(countingLabel)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(countingLabel, forKey: "countingLabel")
        aCoder.encodeObject(strokeColor, forKey: "strokeColor")
        aCoder.encodeObject(strokeColorGradientStart!, forKey: "strokeColorGradientStart")
        aCoder.encodeObject(total, forKey: "total")
        aCoder.encodeObject(current, forKey: "current")
        aCoder.encodeObject(lineWidth, forKey: "lineWidth")
        aCoder.encodeObject(duration, forKey: "duration")
        aCoder.encodeObject(circle, forKey: "circle")
        aCoder.encodeObject(circleBG, forKey: "circleBG")
        
        super.encodeWithCoder(aCoder)
    }

    func degree2radian(angle: Double) -> CGFloat{
        return CGFloat(angle * M_PI / 180)
    }
   
    
    func strokeChart() {
        
        func labelFormat() -> String {
            switch (self.chartType) {
            case .Percent:
                return "%d%%"
                
            case .Dollar:
                return "$%d"
                
            default:
                return "%d"
            }
        }
        
        self.countingLabel.text = NSString(format: labelFormat(), self.current.intValue)
        
        //add animation
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = self.duration
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.fromValue = 0.0;
        pathAnimation.toValue = self.current.floatValue / self.total.floatValue;
        circle.addAnimation(pathAnimation, forKey: "stokeEndAnimation")
        circle.strokeEnd = CGFloat(current.floatValue / total.floatValue);
        
        
        if strokeColorGradientStart != nil {
            let gradientMask = CAShapeLayer()
            gradientMask.fillColor = UIColor.clearColor().CGColor
            gradientMask.strokeColor = UIColor.blackColor().CGColor
            gradientMask.lineWidth = circle.lineWidth
            gradientMask.lineCap = kCALineCapRound
            gradientMask.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width * 2, height: self.bounds.size.height * 2)
            gradientMask.path = circle.path
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.frame = gradientMask.frame
            let colors: [AnyObject] = [strokeColor.CGColor, strokeColorGradientStart!.CGColor]
            gradientLayer.colors = colors
            gradientLayer.mask = gradientMask
            
            circle.addSublayer(gradientLayer)
            
            gradientMask.strokeEnd = CGFloat(current.floatValue / total.floatValue)
            gradientMask.addAnimation(pathAnimation, forKey: "strokeEndAnimation")
        }
        
    }
    
    func growChartByAmount(#amount: NSNumber) {
        let updateValue = current.floatValue + amount.floatValue
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = self.duration
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = updateValue
        circle.strokeEnd = CGFloat(updateValue / total.floatValue)
        circle.addAnimation(pathAnimation, forKey: "stokeEndAnimation")
        
        current = updateValue
    }
    
    

}
