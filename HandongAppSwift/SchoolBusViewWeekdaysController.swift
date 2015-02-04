//
//  SchoolBusViewWeekdaysController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 4..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class SchoolBusViewWeekdaysController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var busList = Array<BusModel>()
    
    @IBOutlet weak var weekdayTimeTableView: UITableView!
    
    override func viewDidLoad() {
        weekdayTimeTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        weekdayTimeTableView.dataSource = self
        weekdayTimeTableView.delegate = self
        
        beginParsing()
    }
    
    func beginParsing() {
        let url = NSURL(string: Util.BusSchoolWeekdaysURL)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler:
            {(data: NSData!, response:NSURLResponse!, error:NSError!) -> Void in
                var xml = SWXMLHash.parse(data)
                
                let count = xml["WeekdayBus"]["tZone"].all.count
                
                var i = 0
                for i=0; i<count; i++ {
                    let timeSplit = xml["WeekdayBus"]["tZone"][i]["timesplit"].element?.text
                    let tzone = xml["WeekdayBus"]["tZone"][i]["tzone"].element?.text
                    
                    //var busList = Array<BusModel>()
                    let busCount = xml["WeekdayBus"]["tZone"][i]["Bus"].all.count
                    
                    var j = 0
                    for j=0; j<busCount; j++ {
                        let six = xml["WeekdayBus"]["tZone"][i]["Bus"][j]["six"].element?.text
                        let hwan = xml["WeekdayBus"]["tZone"][i]["Bus"][j]["hwan"].element?.text
                        let school = xml["WeekdayBus"]["tZone"][i]["Bus"][j]["school"].element?.text
                        
                        //busList.append(BusModel(six: six!, hwan: hwan!, school: school!))
                        
                        self.busList.append(BusModel(six: timeSplit!+six!, hwan: timeSplit!+hwan!, school: timeSplit!+school!))
                    }
                    
                    //self.busTzoneList.append(BusTzoneModel(timeSplit: timeSplit!, tzone: tzone!, bus: busList))
                }
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.weekdayTimeTableView.reloadData()
                })
        })
        dataTask.resume()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.busList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = self.weekdayTimeTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as UITableViewCell
        }
        
        //cell.textLabel?.text = self.busTzoneList[0].bus[0].school + self.busTzoneList[0].bus[0].hwan + self.busTzoneList[0].bus[0].six
        cell.textLabel?.text = self.busList[indexPath.row].school + "  >  " + self.busList[indexPath.row].hwan + "  >  " + self.busList[indexPath.row].six
        
        return cell
    }
}