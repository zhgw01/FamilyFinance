//
//  FirstViewController.swift
//  FamilyFinance
//
//  Created by Zhang Gongwei on 10/8/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

import UIKit

class AccountController: UIViewController{

    
    @IBOutlet weak var barGraph: GKBarGraph!
    override func viewDidLoad() {
        super.viewDidLoad()
        barGraph.backgroundColor = UIColor(patternImage: UIImage(named: "graphbg")!)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        barGraph.draw()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    var data = [60.0, 160.0, 126.4, 262.2, 186.2, 100, 70, 0, 0, 0, 0, 0]
    var labels = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月","十一月", "十二月"]
    
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
