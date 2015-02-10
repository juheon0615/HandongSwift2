//
//  DeliveryFoodModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 10..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class StoreListModel {
    class var sharedInstance: StoreListModel {
        struct Static {
            static var instance: StoreListModel?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = StoreListModel()
        }
        
        return Static.instance!
    }
    
    var storeList = Array<StoreModel>()
}