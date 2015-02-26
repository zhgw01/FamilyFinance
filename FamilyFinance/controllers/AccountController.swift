//
//  FirstViewController.swift
//  FamilyFinance
//
//  Created by Zhang Gongwei on 10/8/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

import UIKit
import ChartKit

class AccountController: UIViewController{

    
    @IBOutlet weak var barGraph: GKBarGraph!    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var ratioChart: CircleChart!
    @IBOutlet weak var incomeLabel: LineLabel!
    @IBOutlet weak var expenseLabel: LineLabel!
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setupDate() {
        let formatter = NSDateFormatter()
        
        formatter.locale = NSLocale(localeIdentifier: "zh_CN")
        formatter.dateFormat = "LLLL"
        
        monthLabel.text = formatter.stringFromDate(NSDate())
    }
    
    private func setStat() {
        if currentMonthIncome != 0 {
            ratioChart.percent = CGFloat(currentMonthExpense / currentMonthIncome);
        } else {
            ratioChart.percent = CGFloat(currentMonthExpense)
        }
        
        incomeLabel.number = Int(currentMonthIncome)
        expenseLabel.number = Int(currentMonthExpense)
    }
    
    func onMonthlyDataChange() {
        setStat()
        barGraph.draw()
    }
    
    private func setupNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMonthlyDataChange", name: monthlyStatNotificationKey, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barGraph.backgroundColor = UIColor(patternImage: UIImage(named: "graphbg")!)
        
        setupDate()
        setStat()
        setupNotification()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //setup bar graph
        if (UIScreen.mainScreen().bounds.height <= 480.0) {
            barGraph.barHeight = 100.0;
        }
        
        let width = barGraph.bounds.size.width;
        let count = barGraph.dataSource!.numberOfBars()
        let barSpace = width / CGFloat(count);
        let barWidth = barSpace > 2.0 ? barSpace / 2.0 + 1 : barSpace
        let barMargin = barSpace - barWidth
        barGraph.barWidth = barWidth;
        barGraph.marginBar = barMargin
        barGraph.draw()
        
    }
    
    var currentMonthExpense: Double {
        let expense = DbManager.sharedInstance.getMonthlyExpense()
        let index = DateUtil.getCurrentMonth()
        return expense[index]
    }
    
    var currentMonthIncome: Double {
        let income = DbManager.sharedInstance.getMonthlyIncome()
        let index = DateUtil.getCurrentMonth()
        return income[index]
    }
    
    var data: [Double] {
        return DbManager.sharedInstance.getMonthlyExpense()
    }
    
    var labels = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月","十月","十一", "十二"]
    
}

extension AccountController: GKBarGraphDataSource
{
    func numberOfBars() -> Int {
        return data.count;
    }
    
    func valueForBarAtIndex(index: Int) -> NSNumber! {
        let count = data.count;
        return data[index % count]
    }
    
    func titleForBarAtIndex(index: Int) -> String! {
        let count = labels.count
        return labels[index % count]
    }
    
    func colorForBarAtIndex(index: Int) -> UIColor! {
        return UIColor(red: 60.0 / 255.0, green: 81.0 / 255.0, blue: 110.0 / 255.0, alpha: 1.0)
    }
    
    func colorForBarBackgroundAtIndex(index: Int) -> UIColor! {
        return UIColor(red: 53.0 / 255.0, green: 49.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
    }
}
