//
//  ReportsController.swift
//  FamilyFinance
//
//  Created by Gongwei on 15/1/28.
//  Copyright (c) 2015年 Zhang Gongwei. All rights reserved.
//

import UIKit

class ReportsController: UITableViewController {
    
    lazy var cashes = Cash.allObjects()
    
    private let dateFormatter = NSDateFormatter()
    private let dayFormatter = NSDateFormatter()
    private let numberFormatter = NSNumberFormatter()
    private let colors = [
                        UIColor(red: 13/255.0, green: 55/255.0, blue: 88/255.0, alpha: 1.0),
                        UIColor(red: 48/255.0, green: 116/255.0, blue: 115/255.0, alpha: 1.0),
                        UIColor(red: 104/255.0, green: 178/255.0, blue: 136/255.0, alpha: 1.0)
                            ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
        dateFormatter.dateFormat = "LLLL"
        
        dayFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
        dayFormatter.dateFormat = "dd"
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
    }
    
    //MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(cashes.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ReportCellIdentifier") as ReportCell
        
        let cash = cashes[UInt(indexPath.row)] as Cash
        
        cell.monthLabel.text = dateFormatter.stringFromDate(cash.created)
        cell.dayLabel.text = dayFormatter.stringFromDate(cash.created)
        cell.categoryImageView.image = UIImage(named: cash.category.image)
        cell.titleLabel.text = cash.title
        cell.numberLabel.text = numberFormatter.stringFromNumber(cash.number)
        
        let colorIndex = indexPath.row % colors.count
        cell.backgroundColor = colors[colorIndex]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 63.0
    }
    
}
