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
    
    let countingLabel: UILabel = UILabel()
    
    var strokeColor: UIColor = PNFreshGreen
    var strokeColorGradientStart: UIColor?
    var total: NSNumber = 100
    var current: NSNumber = 0
    var lineWidth: NSNumber = 8.0
    var duration: NSTimeInterval = 1.0
    var chartType: ChartType = .Percent
    
    let circle: CAShapeLayer = CAShapeLayer()
    let circleBG: CAShapeLayer = CAShapeLayer()
    var clockwise: Bool = false
    var shadow: Bool = false
    
    override var frame: CGRect {
        didSet {
            updateFrame()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        updateFrame()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupComponents()
        updateFrame()
    }
    
    func updateFrame() {
        countingLabel.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 50.0)
        countingLabel.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        let startAngle: CGFloat = clockwise ? -90.0 : 270.0
        let endAngle: CGFloat  = clockwise ? -90.01 : 270.1
        let arcCenter  = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius: CGFloat     = self.bounds.size.height / 2.0
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        
        circle.path = circlePath.CGPath
        circleBG.path = circlePath.CGPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    override func layoutSublayersOfLayer(layer: CALayer!) {
        super.layoutSublayersOfLayer(layer)
        updateFrame()
    }
    
    func setupComponents() {
        
        self.circle.lineCap = kCALineCapRound
        self.circle.lineWidth = CGFloat(self.lineWidth.floatValue)
        self.circle.fillColor = UIColor.clearColor().CGColor
        self.circle.strokeColor = strokeColor.CGColor
        self.circle.zPosition = 1
        
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
