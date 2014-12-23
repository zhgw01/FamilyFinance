//
//  CurrencyTextField.swift
//  FamilyFinance
//
//  Created by Gongwei on 14/12/16.
//  Copyright (c) 2014年 Zhang Gongwei. All rights reserved.
//
//https://github.com/TomSwift/TSCurrencyTextField/blob/master/TSCurrencyTextField/TSCurrencyTextField.m

import UIKit


class CurrencyTextField: UITextField {
    var invalidInputCharacterSet: NSCharacterSet = NSCharacterSet.decimalDigitCharacterSet().invertedSet
    var formatter: NSNumberFormatter = NSNumberFormatter()
    let currencyDelegate = CurrencyTextFieldDelegate()
    var amount: Double {
        get {
            return amountFromString(text)
        }
        
        set(newAmount) {
            let amountString = NSString(format: "%.*lf", formatter.maximumFractionDigits, newAmount)
            text = amountString
        }
    }
    
    override var text: String! {
        get {
            return super.text
        }
        
        set {
            let formatted = formatter.stringFromNumber(amountFromString(newValue))
            super.text = formatted
        }
    }
    
    override var delegate: UITextFieldDelegate? {
        get {
            return currencyDelegate.delegate
        }
        set {
            currencyDelegate.delegate = newValue
        }
    }
    
    
    func setup()
    {
        formatter.locale = NSLocale.currentLocale()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.usesGroupingSeparator = true
        
        super.delegate = currencyDelegate
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setCaratPosition(pos: Int)
    {
        setSelectionRange(NSMakeRange(pos, 0))
    }
    
    func setSelectionRange(range: NSRange)
    {
        if let start = positionFromPosition(beginningOfDocument, offset: range.location) {
            if let end = positionFromPosition(start, offset: range.length) {
                selectedTextRange = textRangeFromPosition(start, toPosition: end)
            }
        }
    }
    
    func amountFromString(string: String) -> Double {
        
        let components = string.componentsSeparatedByCharactersInSet(invalidInputCharacterSet)
        let digitString = join("", components) as NSString
        let fractionDigit = Double(formatter.minimumFractionDigits)
        
        let result = digitString.doubleValue / pow(10.0, fractionDigit)
        
        return result
    }
}

class CurrencyTextFieldDelegate:NSObject, UITextFieldDelegate {
    
    weak var delegate: UITextFieldDelegate?
    
    override func respondsToSelector(aSelector: Selector) -> Bool {
        return super.respondsToSelector(aSelector) || delegate?.respondsToSelector(aSelector) == true
    }
    
    override func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
        if delegate?.respondsToSelector(aSelector) == true {
            return delegate
        }
        else {
            return super.forwardingTargetForSelector(aSelector)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if let currencyTextField = textField as? CurrencyTextField {
            
            let textString: NSString = textField.text
            
            if (textString.length == 0 && range.length == 1 && currencyTextField.invalidInputCharacterSet.characterIsMember(textString.characterAtIndex(range.location))) {
                    currencyTextField.setCaratPosition(range.location)
                    return false;
            }
            
            let distanceFromEnd = textString.length -  (range.location + range.length)
            let changedString = textString.stringByReplacingCharactersInRange(range, withString: string)
            textField.text = changedString
            
            let pos = changedString.utf16Count - distanceFromEnd
            if (pos >= 0 && pos <= changedString.utf16Count) {
                currencyTextField.setCaratPosition(pos)
            }
            
            textField.sendActionsForControlEvents(UIControlEvents.EditingChanged)
            
            return false
        }
        
        

        
        return false
    }
}