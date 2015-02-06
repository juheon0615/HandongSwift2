//
//  MenuModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 5..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class MenuModel {
    var menu: String
    var price: String
    
    init(menu: String?, price: String?) {
        if menu != nil {
            self.menu = menu!
        } else {
            self.menu = " "
        }
        
        if price != nil {
            self.price = price!
        } else {
            self.price = ""
        }
    }
}