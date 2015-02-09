//
//  SecondViewController.swift
//  FamilyFinance
//
//  Created by Zhang Gongwei on 10/8/14.
//  Copyright (c) 2014 Zhang Gongwei. All rights reserved.
//

import UIKit

class FinanceController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Finance.html", ofType: nil)!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }



}

