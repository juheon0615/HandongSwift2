//
//  Util.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 3..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class Util {
    class var ServerURL: String {
        return "https://hgughost.com/HandongServer"
    }
    
    // Server Addr - BUS Schedule
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
    
    // Server Addr - MEAL Info
    class var HacksickURL: String{
        return Util.ServerURL + "/getHaksik.jsp"
    }
    class var MomskitchenURL: String{
        return Util.ServerURL + "/getMoms.jsp"
    }
    class var HyoamthetableURL: String{
        return Util.ServerURL + "/getHyoam.jsp"
    }
    
    // Server Addr - Delivery Food Info
    class var DeliveryFoodURL: String{
        return Util.ServerURL + "/yasick/getYasickStoreList.jsp"
    }
    
    // Server Addr - Main Bus INfo
    class var MainBusSixwayWeekdayURL: String{
        return Util.ServerURL + "/busWidget/getBus_Weekday(toSix).jsp"
    }
    class var MainBusSixwayWeekendURL: String{
        return Util.ServerURL + "/busWidget/getBus_Weekend(toSix).jsp"
    }
    class var MainBusSchoolWeekdayURL: String{
        return Util.ServerURL + "/busWidget/getBus_Weekday(toSchool).jsp"
    }
    class var MainBusSchoolWeekendURL: String{
        return Util.ServerURL + "/busWidget/getBus_Weekend(toSchool).jsp"
    }
    
    // xml file names
    class var SixwayWeekdayBusFilename: String{
        return "swbwd.xml"
    }
    class var SixwayWeekendBusFilename: String{
        return "swbwe.xml"
    }
    class var SchoolWeekdayBusFilename: String{
        return "scbwd.xml"
    }
    class var SchoolWeekendBusFilename: String{
        return "scbwe.xml"
    }
    
    class var DeliveryFoodFilename: String{
        return "yasick.xml"
    }
    
    
    class func saveFile(fileName: String, data: NSData) {
        let fileMgr = NSFileManager.defaultManager()
        let docsDir = Util.getDocumentDirectory()
        
        let filePath = docsDir.stringByAppendingPathComponent(fileName)
        data.writeToFile(filePath, atomically: false)
    }
    
    class func readFile(fileName: String) -> NSString? {
        let fileMgr: NSFileManager = NSFileManager.defaultManager()
        let docsDir = Util.getDocumentDirectory()
        
        let XMLFile = docsDir.stringByAppendingPathComponent(fileName)
        
        
        if fileMgr.fileExistsAtPath(XMLFile) {
            let databuffer = fileMgr.contentsAtPath(XMLFile)
            return NSString(data: databuffer!, encoding: NSUTF8StringEncoding)
        } else {
            return nil
        }
    }
    
    class func weekdayChanger(weekdayInt: Int) -> String {
        switch weekdayInt {
        case 1:
            return "일"
        case 2:
            return "월"
        case 3:
            return "화"
        case 4:
            return "수"
        case 5:
            return "목"
        case 6:
            return "금"
        case 7:
            return "토"
        default:
            return ""
        }
    }
    
    class func showActivityIndicatory(uiView: UIView, inout indicator: UIActivityIndicatorView) {
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = uiView.center
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.Gray
        uiView.addSubview(indicator)
        indicator.startAnimating()
    }
    
    class func getToday() -> NSDateComponents {
        let flags: NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        let date = NSDate()
        return NSCalendar.currentCalendar().components(flags, fromDate: date)
    }
    
    class func isWeekendToday() -> Bool {
        let wd = Util.getWeekday()
        
        if wd == 1 || wd == 7 {
            return true
        } else {
            return false
        }
    }
    
    class func getWeekday() -> Int {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let comp = calendar?.components(.WeekdayCalendarUnit, fromDate: NSDate())
        
        return comp!.weekday
    }
    
    class func getDocumentDirectory() -> String {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return dirPaths[0] as String
    }
}
