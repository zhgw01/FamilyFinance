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
        
        let path = NSBundle.mainBundle().pathForResource("local.html", ofType: nil, inDirectory: "Html")
        let url = NSURL(fileURLWithPath: path!)
        //http://finance.sina.com.cn/fund/box/
        //let url = NSURL(string: "http://m.howbuy.com/fund/")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }



}

