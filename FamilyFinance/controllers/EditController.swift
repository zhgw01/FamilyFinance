//
//  EditController.swift
//  FamilyFinance
//
//  Created by Gongwei on 14/12/10.
//  Copyright (c) 2014年 Zhang Gongwei. All rights reserved.
//

import UIKit

class EditController: UIViewController
{
    
    @IBOutlet weak var categoryView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    private let reuseIdentifier = "CategoryCell"
    
    private var categories: RLMResults!
    private let dbManager = DbManager.sharedInstance
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryView.backgroundColor = UIColor(patternImage: UIImage(named: "graphbg")!)
        
        if let flowLayout = categoryView.collectionViewLayout as? UICollectionViewFlowLayout {
            let top = (categoryView.frame.height - flowLayout.itemSize.height * 2 - flowLayout.minimumInteritemSpacing) / 2.0
            flowLayout.sectionInset = UIEdgeInsets(top: top, left: 0, bottom: top, right: 0)
        }
        
        println(RLMRealm.defaultRealm().path)
        
        //getFiles()
        categories = dbManager.populateCategories()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = true
    }

    
   
    @IBAction func onSave(sender: UIButton) {
        
        let category = Category()
        category.name = "traffic"
        category.image = "car.png"
        category.type = 0
        
        let income = Cash()
        income.number = 100
        income.title = "car"
        income.content = "go to company"
        income.category = category
        
        let db = RLMRealm.defaultRealm()
        db.beginWriteTransaction()
        //db.addObject(category)
        db.addObject(income)
        db.commitWriteTransaction()
        
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
        let category = categories[UInt(indexPath.row)] as Category
        categoryLabel.text = category.name
    }
    
    
}
