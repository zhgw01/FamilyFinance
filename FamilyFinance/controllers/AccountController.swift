//
//  FirstViewController.swift
//  FamilyFinance
//
//  Created by Zhang Gongwei on 10/8/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

import UIKit

class AccountController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circleFrame = CGRect(x: 20, y: 20, width: 100, height: 100)
        let circleButton = CircleButton(frame: circleFrame)
        circleButton.strokeColorGradientStart = PNGreen
        self.view.addSubview(circleButton)
        
        circleButton.growChartByAmount(amount: 30)
        circleButton.strokeChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

