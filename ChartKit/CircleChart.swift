//
//  CircleChart.swift
//  FamilyFinance
//
//  Created by Gongwei on 14/11/23.
//  Copyright (c) 2014年 Zhang Gongwei. All rights reserved.
//

import UIKit


@IBDesignable
class CircleChart: UIView {
    
    enum ChartType {
        case Percent
        case Dollar
        case None
    }
    
    var countingLabel: UILabel!
    
    var backgroundRingLayer: CAShapeLayer!
    var ringLayer: CAShapeLayer!
    
    @IBInspectable var lineWidth:CGFloat = 10.0 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable var strokeColor: UIColor = UIColor.PNFreshGreen
    @IBInspectable var percent: CGFloat = 0.6 {
        didSet {
            updateLayerProperties()
        }
    }
    
    var chartType: ChartType = .Percent
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if countingLabel == nil {
            countingLabel = UILabel(frame: CGRectMake(0, 0,100, 100))
            countingLabel.textAlignment = NSTextAlignment.Center
            countingLabel.font = UIFont.boldSystemFontOfSize(16.0)
            countingLabel.textColor = UIColor.grayColor()
            countingLabel.backgroundColor = UIColor.clearColor()
            countingLabel.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0)
            
            self.addSubview(countingLabel)
            
            self.addConstraint(NSLayoutConstraint(
                item: countingLabel,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1, constant: 0))
            
            
            self.addConstraint(NSLayoutConstraint(
                item: countingLabel,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1, constant: 0))
            
        }
        
        if backgroundRingLayer == nil {
            backgroundRingLayer = CAShapeLayer()
            layer.addSublayer(backgroundRingLayer)
            
            let rect = CGRectInset(bounds, lineWidth / 2.0, lineWidth / 2.0)
            let path = UIBezierPath(ovalInRect: rect)
            
            backgroundRingLayer.path = path.CGPath
            backgroundRingLayer.fillColor = nil
            backgroundRingLayer.lineWidth = lineWidth
            backgroundRingLayer.strokeColor = UIColor.PNLightYellow.CGColor
        }
        backgroundRingLayer.frame = layer.bounds
        
        if ringLayer == nil {
            ringLayer = CAShapeLayer()
            
            let innerRect = CGRectInset(bounds, lineWidth / 2.0, lineWidth / 2.0)
            let innerPath = UIBezierPath(ovalInRect: innerRect)
            
            ringLayer.path = innerPath.CGPath
            ringLayer.fillColor = nil
            ringLayer.lineWidth = lineWidth
            ringLayer.strokeColor = strokeColor.CGColor
            ringLayer.anchorPoint = CGPointMake(0.5, 0.5)
            ringLayer.transform = CATransform3DRotate(ringLayer.transform, -CGFloat(M_PI)/2, 0, 0, 1)
            
            layer.addSublayer(ringLayer)
        }
        ringLayer.frame = layer.bounds
        
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        if (ringLayer != nil) {
            ringLayer.addAnimation(getStrokeAnimation(), forKey: "ringLayerAnimation")
            ringLayer.strokeEnd = percent
        }
        
        if (countingLabel != nil) {
            countingLabel.text = getPercentText()
        }
    }
    
    func getPercentText() -> String {
        func labelFormat() -> String {
            switch(chartType) {
            case .Percent:
                return "%.2f%%"
                
            case .Dollar:
                return "$%.2f"
                
            default:
                return "%.2f"
            }
        }
        
        let result: String = NSString(format: labelFormat(), Double(percent * 100))
        return result
    }
    
    func getStrokeAnimation() -> CAAnimation {
       let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 1.0
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = percent
    
        return pathAnimation
    }
    
}