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
    
    
    //MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(cashes.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ReportCellIdentifier") as UITableViewCell
        
        let cash = cashes[UInt(indexPath.row)] as Cash
        
        cell.textLabel?.text = cash.content
        
        return cell
    }
    
}
