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
    
    var number: NSNumber = NSNumber(unsignedInt: 0){
        didSet {
            let formatted = formatter.stringFromNumber(number)
            text = formatted
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
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 0
        
        
        super.delegate = currencyDelegate
        
        number = NSDecimalNumber(unsignedInt: 0)
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
    var maximumInteger: Int = 7
    var maximumFraction: Int = 2
    
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
    
    func exceedLimit(candidate: String, formatter: NSNumberFormatter) -> Bool {
        
        func digits(rawString: String) -> Int {
            let components = rawString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            let digitStrings = join("", components)
            return digitStrings.utf16Count
        }
        
        let components = candidate.componentsSeparatedByString(formatter.decimalSeparator!)
        if (digits(components[0]) > maximumInteger) {
            return true
        }
        
        if (components.count > 1 && digits(components[1]) > maximumFraction) {
            return true
        }
        
        return false
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let textString = textField.text as NSString
        let candidate = textString.stringByReplacingCharactersInRange(range, withString: string)
        
        
        if let currencyTextField = textField as? CurrencyTextField {
            
            if (exceedLimit(candidate, formatter: currencyTextField.formatter)) {
                return false;
            }
            
            //handle decimal seperator specially
            if let decimialSeperator = currencyTextField.formatter.decimalSeparator {
                if textString.containsString(decimialSeperator) || string == decimialSeperator {
                    return true
                }
            }
            
            //when formatter cannot correctly handle the text
            if let number = currencyTextField.formatter.numberFromString(candidate){
                currencyTextField.number = number
            }
            else {
                
                var intValue = currencyTextField.number.integerValue
                //delete
                if (string.isEmpty) {
                  currencyTextField.number = NSNumber(integer: intValue / 10)
                } else {
                    intValue = intValue * 10
                    if let newValue = string.toInt() {
                        intValue += newValue
                    }
                  currencyTextField.number = NSNumber(integer: intValue)
                }
            }
            
            
            textField.sendActionsForControlEvents(UIControlEvents.EditingChanged)
            return false
        }
        
        return true
        
     }
}