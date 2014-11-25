//
//  CountingLabel.swift
//  FamilyFinance
//
//  Created by Gongwei on 14/11/25.
//  Copyright (c) 2014年 Zhang Gongwei. All rights reserved.
//

import UIKit


class CountingLabel: UILabel
{
    var completionBlock: ((Void)->Void)?
    
    private var progress: NSTimeInterval = 0
    private var lastUpdate: NSTimeInterval = 0
    private var totalTime: NSTimeInterval = 0
    private var startValue: Float = 0
    private var endVale: Float = 0
    private var format: String = "%.2f"
    
    
    func update(t: Float) -> Float
    {
        return t;
    }
    
    func count(#from:Float, to: Float)
    {
        count(from: from, to: to, duration: 2.0)
    }
    
    func count(#from:Float, to: Float, duration:NSTimeInterval)
    {
        startValue = from
        endVale = to
        progress = 0
        totalTime = duration
        lastUpdate = NSDate.timeIntervalSinceReferenceDate()
        
       let timer = NSTimer(timeInterval: 1.0 / 30.0, target: self, selector: "updateValue:", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    
    func updateValue(timer: NSTimer)
    {
        let now = NSDate.timeIntervalSinceReferenceDate()
        progress += now - self.lastUpdate
        lastUpdate = now
        
        if(progress >= totalTime)
        {
            timer.invalidate()
            progress = totalTime
        }
        
        let percent: Float = Float(progress) / Float(totalTime)
        let updateVal = update(percent)
        let value = startValue + updateVal * (endVale - startValue)
        
        self.text =  NSString(format: format, value)
        
        if(progress == totalTime && completionBlock != nil)
        {
            completionBlock!()
        }
    }
 }
