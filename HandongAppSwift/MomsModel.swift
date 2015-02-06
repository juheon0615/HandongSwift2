//
//  MomsModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 6..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class MomsModel {
    var month: String
    var date: String
    var dayOfWeek: String
    
    var breakfast: MenuModel
    var lunchDinner: MenuModel
    
    init(date: String, breakfast: String?, breakfastPrice: String?, lunchDinner: String?, lunchDinnerPrice: String?) {
        let replaced = date.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let monthSplit = replaced.componentsSeparatedByString("월")
        let dateSplit = monthSplit[1].componentsSeparatedByString("일")
        let weekdaySplit = dateSplit[1].componentsSeparatedByString("요")
        
        self.month = String(monthSplit[0].toInt()!)
        self.date = String(dateSplit[0].toInt()!)
        self.dayOfWeek = weekdaySplit[0]
        
        self.breakfast = MenuModel(menu: breakfast, price: breakfastPrice)
        self.lunchDinner = MenuModel(menu: lunchDinner, price: lunchDinnerPrice)
    }
}