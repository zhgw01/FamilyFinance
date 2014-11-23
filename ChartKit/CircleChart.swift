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
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
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
            ringLayer.strokeEnd = percent
        }
    }
    
}