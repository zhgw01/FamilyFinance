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
    
    func goBack() {
        webView.goBack()
    }
    
    func goForward() {
        webView.goForward()
    }
    
    private func setupGesture() {
        //ToDo: how to add selector with parameter
        let backSwipe = UISwipeGestureRecognizer(target: self, action: "goBack")
        backSwipe.numberOfTouchesRequired = 1
        backSwipe.direction = UISwipeGestureRecognizerDirection.Right
        backSwipe.delegate = self
        
        webView.addGestureRecognizer(backSwipe)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGesture()
        
        let path = NSBundle.mainBundle().pathForResource("local.html", ofType: nil, inDirectory: "Html")
        let url = NSURL(fileURLWithPath: path!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

}

extension FinanceController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
}

