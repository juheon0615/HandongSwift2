//
//  SchoolBusViewWeekdaysController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 4..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class SchoolBusViewWeekdayController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var busTzoneList = Array<BusTzoneModel>()
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var weekdayTimeTableView: UITableView!
    
    override func viewDidLoad() {
        weekdayTimeTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        weekdayTimeTableView.dataSource = self
        weekdayTimeTableView.delegate = self
        
        beginParsing()
        
        // INIT top bar
        
        let tableWidth = weekdayTimeTableView.frame.width
        let labelWidth = (tableWidth-60)/3.0
        // add time labels
        let fstLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: labelWidth, height: 30.0))
        fstLabel.text = "육거리"
        fstLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        fstLabel.textAlignment =  NSTextAlignment.Center
        topBar.addSubview(fstLabel)
        
        let sndLabel = UILabel(frame: CGRect(x: labelWidth + 30, y: 0.0, width: labelWidth, height: 30.0))
        sndLabel.text = "환호동"
        sndLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        sndLabel.textAlignment =  NSTextAlignment.Center
        topBar.addSubview(sndLabel)
        
        let trdLabel = UILabel(frame: CGRect(x: (labelWidth + 30)*2, y: 0.0, width: labelWidth, height: 30.0))
        trdLabel.text = "학교"
        trdLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        trdLabel.textAlignment =  NSTextAlignment.Center
        topBar.addSubview(trdLabel)
        
        
        // add arrow labels
        let arrow1 = UILabel(frame: CGRect(x: labelWidth, y: 0.0, width: 30.0, height: 30.0))
        arrow1.text = ">"
        arrow1.textAlignment = NSTextAlignment.Center
        topBar.addSubview(arrow1)
        let arrow2 = UILabel(frame: CGRect(x: labelWidth*2 + 30, y: 0.0, width: 30.0, height: 30.0))
        arrow2.text = ">"
        arrow2.textAlignment = NSTextAlignment.Center
        topBar.addSubview(arrow2)
    }
    
    func beginParsing() {
        let fileData = Util.readFile(Util.SchoolWeekdayBusFilename)
        
        if fileData != nil {
            let xml = SWXMLHash.parse(fileData!)
                
            let count = xml["WeekdayBus"]["tZone"].all.count
            
            var i = 0
            for i=0; i<count; i++ {
                let timeSplit = xml["WeekdayBus"]["tZone"][i]["timesplit"].element?.text
                let tzone = xml["WeekdayBus"]["tZone"][i]["tzone"].element?.text
                
                var busList = Array<BusModel>()
                let busCount = xml["WeekdayBus"]["tZone"][i]["Bus"].all.count
                
                var j = 0
                for j=0; j<busCount; j++ {
                    let six = xml["WeekdayBus"]["tZone"][i]["Bus"][j]["six"].element?.text
                    let hwan = xml["WeekdayBus"]["tZone"][i]["Bus"][j]["hwan"].element?.text
                    let school = xml["WeekdayBus"]["tZone"][i]["Bus"][j]["school"].element?.text
                    
                    busList.append(BusModel(six: six!, hwan: hwan!, school: school!))
                }
                
                self.busTzoneList.append(BusTzoneModel(timeSplit: timeSplit!, tzone: tzone!, bus: busList))
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.weekdayTimeTableView.reloadData()
            })
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.busTzoneList.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.busTzoneList[section].bus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = self.weekdayTimeTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as UITableViewCell
        }
        
        // remove previous labels
        for view in cell.subviews {
            view.removeFromSuperview()
        }
        
        
        let tableWidth = tableView.frame.width
        let labelWidth = (tableWidth-60)/3.0
        // add time labels
        let fstLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: labelWidth, height: 30.0))
        fstLabel.text = self.busTzoneList[indexPath.section].bus[indexPath.row].six
        fstLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        fstLabel.textAlignment =  NSTextAlignment.Center
        cell.addSubview(fstLabel)
        
        let sndLabel = UILabel(frame: CGRect(x: labelWidth + 30, y: 0.0, width: labelWidth, height: 30.0))
        sndLabel.text = self.busTzoneList[indexPath.section].bus[indexPath.row].hwan
        sndLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        sndLabel.textAlignment =  NSTextAlignment.Center
        cell.addSubview(sndLabel)
        
        let trdLabel = UILabel(frame: CGRect(x: (labelWidth + 30)*2, y: 0.0, width: labelWidth, height: 30.0))
        trdLabel.text = self.busTzoneList[indexPath.section].bus[indexPath.row].school
        trdLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        trdLabel.textAlignment =  NSTextAlignment.Center
        cell.addSubview(trdLabel)
        
        
        // add arrow labels
        let arrow1 = UILabel(frame: CGRect(x: labelWidth, y: 0.0, width: 30.0, height: 30.0))
        arrow1.text = ">"
        arrow1.textAlignment = NSTextAlignment.Center
        cell.addSubview(arrow1)
        let arrow2 = UILabel(frame: CGRect(x: labelWidth*2 + 30, y: 0.0, width: 30.0, height: 30.0))
        arrow2.text = ">"
        arrow2.textAlignment = NSTextAlignment.Center
        cell.addSubview(arrow2)
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return busTzoneList[section].timeSplit + " " + busTzoneList[section].tzone
    }
}