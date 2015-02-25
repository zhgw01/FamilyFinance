//
//  LineLabel.swift
//  FamilyFinance
//
//  Created by Gongwei on 14/12/8.
//  Copyright (c) 2014年 Zhang Gongwei. All rights reserved.
//

import UIKit

@IBDesignable
public class LineLabel: UIView {
    
    var numberLabel: UILabel = UILabel()
    @IBInspectable public var number: Int = 0 {
        didSet {
            let format = NSNumberFormatter()
            format.usesGroupingSeparator = true
            format.groupingSeparator = ","
            format.groupingSize = 3
            
            numberLabel.text = format.stringFromNumber(number)
        }
    }
    @IBInspectable public var numberLabelFontSize: CGFloat = 20 {
        didSet {
            numberLabel.font = UIFont.systemFontOfSize(numberLabelFontSize)
        }
    }
    @IBInspectable public var numberLabelFontColor: UIColor = UIColor.whiteColor() {
        didSet {
            numberLabel.textColor = numberLabelFontColor
        }
    }
    
    var categoryLabel: UILabel = UILabel()
    @IBInspectable var category: String = "total" {
        didSet {
            categoryLabel.text = category
        }
    }
    @IBInspectable var categoryLabelFontSize: CGFloat = 12 {
        didSet {
            categoryLabel.font = UIFont.systemFontOfSize(categoryLabelFontSize)
        }
    }
    @IBInspectable var categoryLabelFontColor: UIColor = UIColor.grayColor() {
        didSet {
            categoryLabel.textColor = categoryLabelFontColor
        }
    }
    
    var upperLine: CAShapeLayer!
    var bottomLine: CAShapeLayer!
    var lineBorder: CGFloat = 1.0
    @IBInspectable var upperLineColor: UIColor =  UIColor(red: 59.0 / 255.0, green: 55.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0) {
        didSet {
            upperLine?.strokeColor = upperLineColor.CGColor
        }
    }
    @IBInspectable var bottomLineColor: UIColor =  UIColor(red: 59.0 / 255.0, green: 55.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0) {
        didSet {
            bottomLine?.strokeColor = bottomLineColor.CGColor
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        self.addSubview(numberLabel)
        self.addSubview(categoryLabel)
        categoryLabel.textAlignment = NSTextAlignment.Right
        setupSubViewFrame()
    }
    
    func setupSubViewFrame() {
        
        let innerRect = CGRectInset(self.bounds, 1.0, lineBorder)
        var leftRect = CGRectZero
        var rightRect = CGRectZero
        CGRectDivide(self.bounds, &leftRect, &rightRect, self.bounds.width * 0.6, CGRectEdge.MinXEdge)
        
        numberLabel.frame = leftRect
        categoryLabel.frame = rightRect
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if upperLine == nil {
            upperLine = CAShapeLayer()
            let linePath = UIBezierPath()
            linePath.moveToPoint(CGPointMake(0, 0))
            linePath.addLineToPoint(CGPointMake(frame.size.width, 0))
            upperLine.path = linePath.CGPath
            upperLine.strokeColor = upperLineColor.CGColor
            layer.addSublayer(upperLine)
        }
        upperLine.frame = bounds
        
        if bottomLine == nil {
            bottomLine = CAShapeLayer()
            let linePath = UIBezierPath()
            linePath.moveToPoint(CGPointMake(0, frame.size.height - lineBorder))
            linePath.addLineToPoint(CGPointMake(frame.size.width, frame.size.height - lineBorder))
            bottomLine.path = linePath.CGPath
            bottomLine.strokeColor = bottomLineColor.CGColor
            bottomLine.fillColor = nil
            layer.addSublayer(bottomLine)
        }
        bottomLine.frame = bounds
        
        
        setupSubViewFrame()
    }
    
}
