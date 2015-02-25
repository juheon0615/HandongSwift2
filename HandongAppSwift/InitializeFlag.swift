//
//  InitializeFlag.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 24..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class InitializeFlag {
    class var sharedInstance: InitializeFlag {
        struct Static {
            static var instance: InitializeFlag?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = InitializeFlag()
        }
        
        return Static.instance!
    }
    
    var flag = false
}