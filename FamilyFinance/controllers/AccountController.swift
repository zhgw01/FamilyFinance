//
//  FirstViewController.swift
//  FamilyFinance
//
//  Created by Zhang Gongwei on 10/8/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

import UIKit

class AccountController: UIViewController {

    @IBOutlet weak var circleChart: CircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleChart.current = 30
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        circleChart.strokeChart()
    }
  


}

