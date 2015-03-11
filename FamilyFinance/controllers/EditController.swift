//
//  EditController.swift
//  FamilyFinance
//
//  Created by Gongwei on 14/12/10.
//  Copyright (c) 2014年 Zhang Gongwei. All rights reserved.
//

import UIKit
import ChartKit

class EditController: UIViewController
{
    
    @IBOutlet weak var categoryView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    private let reuseIdentifier = "CategoryCell"
    
    private var categories: RLMResults!
    private let dbManager = DbManager.sharedInstance
    
    private var cashNumber = 0.0
    private var cashDescription = ""
    
    private var categoryType: CategoryType = .Expand
    private var selectedCategory: UInt = 0 {
        didSet {
            let category = categories[selectedCategory] as Category
            categoryLabel.text = category.name
        }
    }
    
    private var createdDate = NSDate()
    
    private func setMonth(date: NSDate) {
        let formatter = NSDateFormatter()
        

        formatter.dateFormat = "LLLL"
        
        monthLabel.text = formatter.stringFromDate(date)
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryView.backgroundColor = UIColor(patternImage: UIImage(named: "graphbg")!)
        
        
        //println(RLMRealm.defaultRealm().path)
        
        categories = dbManager.populateCategories().objectsWhere("type=%d", categoryType.rawValue)
        selectedCategory = 0
        
    
        setMonth(createdDate)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = true
    }

    
    @IBAction func onCategoryTypeChange(sender: UISegmentedControl) {
        
        categoryType = CategoryType(rawValue:sender.selectedSegmentIndex)!
        categories = dbManager.populateCategories().objectsWhere("type=%d", categoryType.rawValue)
        selectedCategory = 0
        categoryView.reloadData()
        
    }
   
    @IBAction func onSave(sender: UIButton) {
        
        if (cashNumber <= 0) {
            let alertView = UIAlertController(title: "请输入金额", message: "金额不能小于零", preferredStyle: .Alert)
            alertView.view.backgroundColor = UIColor.blackColor()
            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertView, animated: true, completion: nil)
            return
        }
        
        
        let category = categories[selectedCategory] as Category
        
        let newCash = Cash()
        newCash.title = category.name
        newCash.content = cashDescription
        newCash.number = cashNumber
        newCash.category = category
        newCash.type = categoryType.rawValue
        newCash.created = createdDate

        dbManager.addCash(newCash)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func onCancel(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}


extension EditController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(categories.count)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as CategoryCell
        
        //configure the cell
        let category = categories[UInt(indexPath.row)] as Category
        
        cell.imageView.image = UIImage(named: category.image)
        cell.label.text = category.name
        
        return cell
        
    }
}

extension EditController: UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedCategory = UInt(indexPath.row)

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            var top = (collectionView.frame.height - flowLayout.itemSize.height * 2 - flowLayout.minimumInteritemSpacing) / 2.0
            if (top < 0  ) {
                top = 0
            }
            return UIEdgeInsets(top: top, left: 0, bottom: top, right: 0)
        }

        return UIEdgeInsetsZero
    }
    
}

extension EditController: UITextFieldDelegate
{
    func textFieldDidEndEditing(textField: UITextField) {
        if let currencyTextuField = textField as? CurrencyTextField {
            if let number = currencyTextuField.number as? Double {
                cashNumber = number;
            }
        }
    }
}

extension EditController: UITextViewDelegate
{
    func textViewDidEndEditing(textView: UITextView) {
        cashDescription = textView.text
        textView.resignFirstResponder()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
}
