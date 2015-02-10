//
//  MainBusModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 8..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class MainBusModel {
    class var sharedInstance: MainBusModel {
        struct Static {
            static var instance: MainBusModel?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = MainBusModel()
        }
        
        return Static.instance!
    }
    
    var toSix = Array<BusModel>()
    var toSchool = Array<BusModel>()
}