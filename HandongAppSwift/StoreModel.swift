//
//  DeliveryFoodItemModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 10..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class StoreModel {
    var id: String
    var name: String
    var phone: String
    var runTime: String
    var category: String
    
    init(id: String, name: String, phone: String?, runTime: String?, category: String?) {
        self.id = id
        self.name = name
        self.phone = (phone != nil ? phone! : "")
        self.runTime = (runTime != nil ? runTime! : "")
        self.category = (category != nil ? category! : "")
    }
}