//
//  FirstViewController.swift
//  FamilyFinance
//
//  Created by Zhang Gongwei on 10/8/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

import UIKit


class AccountController: UIViewController {

    @IBOutlet weak var lineChartView: UIView!
    var lineChart: PNLineChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if lineChart == nil {
            createLineChart()
        }
        
        lineChart.frame = lineChartView.bounds
        lineChart.strokeChart()
    }
    
    func createLineChart() {
        lineChart = PNLineChart(frame: lineChartView.bounds)
        
        lineChart.xLabels = ["SEP 1", "SEP 2", "SEP 3", "SEP 4", "SEP 5"]
        
        let data = [60.0, 160.0, 126.4, 262.2, 186.2]
        let chartData = PNLineChartData()
        chartData.color = UIColor(red:77.0 / 255.0 , green:176.0 / 255.0, blue:122.0 / 255.0, alpha:1.0)
        chartData.itemCount = UInt(lineChart.xLabels.count)
        chartData.getData = { (index: UInt) -> PNLineChartDataItem in
            let yValue = data[Int(index)]
            return PNLineChartDataItem(y: CGFloat(yValue))
        }
        
        lineChart.chartData = [chartData]
        
        lineChartView.addSubview(lineChart)
        
    }

}

