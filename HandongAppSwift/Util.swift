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
    class func DeliveryDetailURL(id: String) -> String{
        return Util.ServerURL + "/yasick/get" + id + ".jsp"
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
    class func DeliveryDetailFilename(id: String) -> String {
        return id + ".xml"
    }
    
    
    // KEY STRING for USER DEFAULT - recent call
    class var RecentCallKey: String{
        return "RECENTCALLYASICK"
    }
    class var recentCallSpliter: String{
        // split ID and Time value with this string
        return "-"
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
    
    class func checkImage(fileName: String) -> Bool {
        let fileMgr: NSFileManager = NSFileManager.defaultManager()
        let docsDir = Util.getDocumentDirectory()
        
        let imageFile = docsDir.stringByAppendingPathComponent(fileName)
        
        
        return fileMgr.fileExistsAtPath(imageFile)
    }
    
    class func checkAndDownloadImage(id: String, urlString: String) {
        let fileName = urlString.componentsSeparatedByString("/").last!
        
        if !Util.checkImage(id + "/" + fileName) {
            let url = NSURL(string: urlString)!
            let session = NSURLSession.sharedSession()
            
            let dataTask = session.dataTaskWithURL(url, completionHandler:
                {(data: NSData!, response:NSURLResponse!, error:NSError!) -> Void in
                    Util.saveFile(id + "/" + fileName, data: data)
            })
            dataTask.resume()
        }
    }
    
    class func readImage(fileName: String) -> NSData? {
        let fileMgr: NSFileManager = NSFileManager.defaultManager()
        let docsDir = Util.getDocumentDirectory()
        
        let imageFile = docsDir.stringByAppendingPathComponent(fileName)
        
        
        if fileMgr.fileExistsAtPath(imageFile) {
            return fileMgr.contentsAtPath(imageFile)
        } else {
            return nil
        }
    }
    
    class func removeFile(fileName: String) -> Bool {
        let fileMgr = NSFileManager.defaultManager()
        let docsDir = Util.getDocumentDirectory()
        
        let XMLFile = docsDir.stringByAppendingPathComponent(fileName)
        var error: NSError?
        
        if fileMgr.fileExistsAtPath(XMLFile) {
            return fileMgr.removeItemAtPath(XMLFile, error: &error)
        } else {
            return false
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
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    class func hideActivityIndicator(inout indicator: UIActivityIndicatorView) {
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        indicator.stopAnimating()
    }
    
    class func getCurrentTime() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit | .CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minutes = components.minute
        
        let retString = String(year%100) + "/" + String(month) + "/" + String(day) + " " + String(hour) + ":" + String(minutes)
        
        return retString
    }
    
    class func getToday() -> NSDateComponents {
        let flags: NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit | .WeekdayCalendarUnit
        
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
    
    class func makeImageDirectory(id: String) {
        let filemgr = NSFileManager.defaultManager()
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        let newDir = docsDir.stringByAppendingPathComponent(id)
        
        var error: NSError?
        
        if !filemgr.createDirectoryAtPath(newDir,
            withIntermediateDirectories: true,
            attributes: nil,
            error: &error) {
                
                println("Failed to create dir: \(error!.localizedDescription)")
        }
    }
    
    class func makePhoneCall(phoneNumber: String, storeID: String) {
        let url = NSURL(string: "tel://" + phoneNumber)
        UIApplication.sharedApplication().openURL(url!)
        
        Util.registerRecentCall(storeID)
    }
    
    class func registerRecentCall(storeID: String) {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        var recent: Array<String>? = userDefaults.valueForKey(Util.RecentCallKey) as Array<String>?
        
        if recent != nil {
            recent!.insert(storeID + Util.recentCallSpliter + Util.getCurrentTime(), atIndex: 0)
            
            // limit call history count
            if recent!.count > 10 {
                recent!.removeLast()
            }
        } else {
            recent = Array<String>()
            recent!.insert(storeID + Util.recentCallSpliter + Util.getCurrentTime(), atIndex: 0)
        }
    
        userDefaults.setObject(recent, forKey: Util.RecentCallKey)
    }
}
