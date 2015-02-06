//
//  HacksickModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 5..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class HacksickModel {
    var month: String
    var date: String
    var dayOfWeek: Int
    
    var breakfast: MenuModel
    var lunch: MenuModel
    var dinner: MenuModel
    
    var fryFry: MenuModel
    var noodleRoad: MenuModel
    var hao: MenuModel
    var graceGarden: MenuModel
    var mixRice: MenuModel
    
    init(date: String, breakfast: String?, breakfastPrice: String?, lunch: String?, lunchPrice: String?, dinner: String?, dinnerPrice: String?, fryFry: String?, fryFryPrice: String?, noodleRoad: String?, noodleRoadPrice: String?, hao: String?, haoPrice: String?, graceGarden: String?, graceGardenPrice: String?, mixRice: String?, mixRicePrice: String?) {
        
        let dateInt = date.toInt()
        self.month = String(dateInt!/100)
        self.date = String(dateInt!%100)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let today = NSCalendar.currentCalendar().components(.YearCalendarUnit, fromDate: NSDate())
        let formattedDate = formatter.dateFromString(String(today.year)+date) // TODOHERE
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let comp = calendar?.components(.WeekdayCalendarUnit, fromDate: formattedDate!)
        
        self.dayOfWeek = comp!.weekday
        
        self.breakfast  = MenuModel(menu: breakfast, price: breakfastPrice)
        self.lunch      = MenuModel(menu: lunch, price: lunchPrice)
        self.dinner     = MenuModel(menu: dinner, price: dinnerPrice)
        
        self.fryFry         = MenuModel(menu: fryFry, price: fryFryPrice)
        self.noodleRoad     = MenuModel(menu: noodleRoad, price: noodleRoadPrice)
        self.hao            = MenuModel(menu: hao, price: haoPrice)
        self.graceGarden    = MenuModel(menu: graceGarden, price: graceGardenPrice)
        self.mixRice        = MenuModel(menu: mixRice, price: mixRicePrice)
    }
}