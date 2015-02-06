//
//  HyoamModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 6..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class HyoamModel {
    var month: String
    var date: String
    var dayOfWeek: String
    
    var special: MenuModel
    var normal = Array<MenuModel>()
    
    init(date: String, special: String?, specialPrice: String?, normal: Array<String?>, normalPrice: Array<String?>) {
        let replaced = date.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let monthSplit = replaced.componentsSeparatedByString("월")
        let dateSplit = monthSplit[1].componentsSeparatedByString("일")
        let weekdaySplit = dateSplit[1].componentsSeparatedByString("요")
        
        self.month = String(monthSplit[0].toInt()!)
        self.date = String(dateSplit[0].toInt()!)
        self.dayOfWeek = weekdaySplit[0]
        
        self.special = MenuModel(menu: special, price: specialPrice)
        
        for i in 0 ..< normal.count {
            self.normal.append(MenuModel(menu: normal[i], price: normalPrice[i]))
        }
    }
}