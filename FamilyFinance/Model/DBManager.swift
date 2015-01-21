//
//  DBManager.swift
//  FamilyFinance
//
//  Created by Gongwei on 15/1/21.
//  Copyright (c) 2015年 Zhang Gongwei. All rights reserved.
//

import Foundation


class DbManager: NSObject {
    
    class var sharedInstance:  DbManager {
        struct Static {
            static let instance: DbManager = DbManager()
        }
        
        return Static.instance
    }
    
    let db = RLMRealm.defaultRealm()
    
    
    func populateCategories() -> RLMResults {
        var categories = Category.allObjects()
        
        if categories.count == 0 {
            addDefaultCategory()
            categories = Category.allObjects()
        }
        
        return categories
    }
    
    private func addDefaultCategory() {
        
        let defaultCategories = [
            "衣服": "cloth",
            "娱乐": "entertainment",
            "食品": "food",
            "房租": "house",
            "看病": "medicine",
            "购物": "shopping",
            "交通": "taxi",
            "其它": "label"
        ]
        
        db.beginWriteTransaction()
        
        for (name, icon) in defaultCategories {
            let newCategory = Category()
            
            newCategory.name = name
            newCategory.image = icon
            
            db.addObject(newCategory)
            
        }
        
        db.commitWriteTransaction()
        
    }
}