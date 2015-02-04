//
//  Util.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 3..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class Util {
    class var ServerURL: String {
        return "https://hgughost.com/HandongServer"
    }
    
    class var BusSixwayWeekdaysURL: String{
        return Util.ServerURL + "/bus/getBus_Weekday(toSix).jsp"
    }
    class var BusSixwayWeekendURL: String{
        return Util.ServerURL + "/bus/getBus_Weekend(toSix).jsp"
    }
    class var BusSchoolWeekdaysURL: String{
        return Util.ServerURL + "/bus/getBus_Weekday(toSchool).jsp"
    }
    class var BusSchoolWeekendURL: String{
        return Util.ServerURL + "/bus/getBus_Weekend(toSchool).jsp"
    }
}
