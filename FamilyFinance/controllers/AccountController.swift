//
//  FirstViewController.swift
//  FamilyFinance
//
//  Created by Zhang Gongwei on 10/8/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

import UIKit

class AccountController: UIViewController, GKLineGraphDataSource{

    
    @IBOutlet weak var lineGraph: GKLineGraph!
    override func viewDidLoad() {
        super.viewDidLoad()
        lineGraph.lineWidth = 3.0
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lineGraph.draw()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    var lineData = [[60.0, 160.0, 126.4, 262.2, 186.2]]
    var labels = ["Jan", "Feb", "Mar", "April", "May"]
    
    
    func numberOfLines() -> Int {
        return lineData.count
    }
    
    func colorForLineAtIndex(index: Int) -> UIColor {
        let colors = [UIColor.gk_turquoiseColor(),
                    UIColor.gk_peterRiverColor(),
                    UIColor.gk_alizarinColor(),
                    UIColor.gk_sunflowerColor()]
        let count = colors.count
        
        return colors[index % count]
    }
    
    func valuesForLineAtIndex(index: Int) -> [AnyObject]! {
        return lineData[index]
    }
    
    func titleForLineAtIndex(index: Int) -> String! {
        let count = labels.count
        return labels[index % count]
    }

}

