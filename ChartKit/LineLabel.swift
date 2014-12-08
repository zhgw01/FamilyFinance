//
//  LineLabel.swift
//  FamilyFinance
//
//  Created by Gongwei on 14/12/8.
//  Copyright (c) 2014年 Zhang Gongwei. All rights reserved.
//

import UIKit

@IBDesignable
class LineLabel: UIView {
    
    var numberLabel: UILabel = UILabel()
    @IBInspectable var number: Int = 0
    @IBInspectable var numberLabelFontSize: CGFloat = 20 {
        didSet {
            numberLabel.font = UIFont.systemFontOfSize(numberLabelFontSize)
        }
    }
    @IBInspectable var numberLabelFontColor: UIColor = UIColor.whiteColor() {
        didSet {
            numberLabel.textColor = numberLabelFontColor
        }
    }
    
    var categoryLabel: UILabel = UILabel()
    @IBInspectable var category: String = "total"
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
    
    var upperLine: UIView!
    var bottomLine: UIView!
    var lineBorder: CGFloat = 2.0
    @IBInspectable var decoratorLineColor: UIColor =  UIColor(red: 59.0 / 255.0, green: 55.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0) {
        didSet {
            upperLine.backgroundColor = decoratorLineColor
            bottomLine.backgroundColor = decoratorLineColor
        }
    }
    
    required init(coder aDecoder: NSCoder) {
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
    }
    
    func setupSubViewFrame() {
        upperLine.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: lineBorder)
        bottomLine.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1.0)
        
        let innerRect = CGRectInset(self.bounds, 1.0, lineBorder)
        var leftRect = CGRectZero
        var rightRect = CGRectZero
        CGRectDivide(self.bounds, &leftRect, &rightRect, self.bounds.width * 0.6, CGRectEdge.MaxXEdge)
        
        numberLabel.frame = leftRect
        categoryLabel.frame = rightRect
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if upperLine == nil {
            upperLine = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: lineBorder))
            upperLine.backgroundColor = decoratorLineColor
            self.addSubview(upperLine)
        }
        
        if bottomLine == nil {
            bottomLine = UIView(frame: CGRect(x: 0, y: frame.size.height - lineBorder, width: frame.size.width, height: lineBorder))
            bottomLine.backgroundColor = decoratorLineColor
            self.addSubview(bottomLine)
        }
        
        
        setupSubViewFrame()
    }
    
}
