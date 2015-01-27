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
    
    
    func addCash(cash: Cash) {
        db.beginWriteTransaction()
        db.addObject(cash)
        db.commitWriteTransaction()
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
        
        let defaultIncomeCategories = [
            "工资": "salary",
            "奖金": "bonus",
            "投资": "stock",
            "其它": "other"
        ]
        
        db.beginWriteTransaction()
        
        for (name, icon) in defaultCategories {
            let newCategory = Category()
            
            newCategory.name = name
            newCategory.image = icon
            newCategory.type = 0
            
            db.addObject(newCategory)
        }
        
        for (name, icon) in defaultIncomeCategories {
            let newCategory = Category()
            
            newCategory.name = name
            newCategory.image = icon
            newCategory.type = 1
            
            db.addObject(newCategory)
        }
        
        db.commitWriteTransaction()
        
    }
}