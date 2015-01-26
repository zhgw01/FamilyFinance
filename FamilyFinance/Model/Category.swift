//
//  Category.swift
//  FamilyFinance
//
//  Created by Gongwei on 15/1/20.
//  Copyright (c) 2015年 Zhang Gongwei. All rights reserved.
//

enum CategoryType: Int {
    case Expand = 0
    case Income
}

class Category: RLMObject {
    dynamic var name = ""
    dynamic var image = ""
    dynamic var type = 0
}
