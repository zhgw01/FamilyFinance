//
//  Cash.swift
//  FamilyFinance
//
//  Created by Gongwei on 15/1/20.
//  Copyright (c) 2015年 Zhang Gongwei. All rights reserved.
//

enum CashSortedType: String {
    case Date = "created"
    case Number = "number"
}

class Cash: RLMObject {
    dynamic var number: Double = 0.0
    dynamic var type = 0
    dynamic var title = ""
    dynamic var content = ""
    dynamic var created = NSDate()
    dynamic var category = Category()
}


