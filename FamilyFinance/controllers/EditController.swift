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
    
    private var images = [String]()
    
    func getFiles() {
        let paths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: nil) as? [String]
        if paths != nil {
            images = paths!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryView.backgroundColor = UIColor(patternImage: UIImage(named: "graphbg")!)
        
        if let flowLayout = categoryView.collectionViewLayout as? UICollectionViewFlowLayout {
            let top = (categoryView.frame.height - flowLayout.itemSize.height * 2 - flowLayout.minimumInteritemSpacing) / 2.0
            flowLayout.sectionInset = UIEdgeInsets(top: top, left: 0, bottom: top, right: 0)
        }
        
        getFiles()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = true
    }
}


extension EditController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as CategoryCell
        
        //configure the cell
        let imagePath = images[indexPath.row]
        cell.imageView.image = UIImage(named: imagePath)
        
        cell.label.text = NSFileManager.defaultManager().displayNameAtPath(imagePath).stringByDeletingPathExtension
        
        return cell
        
    }
}

extension EditController: UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let imagePath = images[indexPath.row]
        let basename = NSFileManager.defaultManager().displayNameAtPath(imagePath).stringByDeletingPathExtension
        categoryLabel.text = basename
    }
    
    
}
