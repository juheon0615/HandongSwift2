//
//  LoadingViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 3..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    enum BusTimeType {
        case SixwayWeekday
        case SixwayWeekend
        case SchoolWeekday
        case SchoolWeekend
    }
    
    @IBOutlet weak var loadingImg: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
    
    var fileMgr: NSFileManager = NSFileManager.defaultManager()
    var docsDir: String?
    var sixwayBusWeekendXMLFile: String?
    var sixwayBusWeekdayXMLFile: String?
    var schoolBusWeekendXMLFile: String?
    var schoolBusWeekdayXMLFile: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rotationAni = CABasicAnimation()
        rotationAni.keyPath = "transform.rotation.z";
        rotationAni.toValue = NSNumber(double: M_PI * 2)
        rotationAni.duration = 2
        rotationAni.cumulative = true
        rotationAni.repeatCount = Float.infinity
        
        loadingImg.layer.addAnimation(rotationAni, forKey: "rotationAnimation")
        
        
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        docsDir = dirPaths[0] as? String
        sixwayBusWeekdayXMLFile = docsDir?.stringByAppendingPathComponent(Util.SixwayWeekdayBusFilename)
        sixwayBusWeekendXMLFile = docsDir?.stringByAppendingPathComponent(Util.SixwayWeekendBusFilename)
        schoolBusWeekdayXMLFile = docsDir?.stringByAppendingPathComponent(Util.SchoolWeekdayBusFilename)
        schoolBusWeekendXMLFile = docsDir?.stringByAppendingPathComponent(Util.SchoolWeekendBusFilename)
        
        var version: String? = nil
        if fileMgr.fileExistsAtPath(sixwayBusWeekdayXMLFile!) {
            let databuffer = fileMgr.contentsAtPath(sixwayBusWeekdayXMLFile!)
            var datastring = NSString(data: databuffer!,
                encoding: NSUTF8StringEncoding)
            
            version = self.checkBusXMLVersion(datastring!)
        }
        getBusDataFromServer(BusTimeType.SixwayWeekday, version: version)
        
        version = nil
        if fileMgr.fileExistsAtPath(sixwayBusWeekendXMLFile!) {
            let databuffer = fileMgr.contentsAtPath(sixwayBusWeekendXMLFile!)
            var datastring = NSString(data: databuffer!,
                encoding: NSUTF8StringEncoding)
            
            version = self.checkBusXMLVersion(datastring!)
        }
        getBusDataFromServer(BusTimeType.SixwayWeekend, version: version)
        
        version = nil
        if fileMgr.fileExistsAtPath(schoolBusWeekdayXMLFile!) {
            let databuffer = fileMgr.contentsAtPath(schoolBusWeekdayXMLFile!)
            var datastring = NSString(data: databuffer!,
                encoding: NSUTF8StringEncoding)
            
            version = self.checkBusXMLVersion(datastring!)
        }
        getBusDataFromServer(BusTimeType.SchoolWeekday, version: version)
        
        version = nil
        if fileMgr.fileExistsAtPath(schoolBusWeekendXMLFile!) {
            let databuffer = fileMgr.contentsAtPath(schoolBusWeekendXMLFile!)
            var datastring = NSString(data: databuffer!,
                encoding: NSUTF8StringEncoding)
            
            version = self.checkBusXMLVersion(datastring!)
        }
        getBusDataFromServer(BusTimeType.SchoolWeekend, version: version)
    }
    
    override func viewDidAppear(animated: Bool) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("nextPage"), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func nextPage() {
        self.performSegueWithIdentifier("loadingDoneSegue", sender: self)
    }
    
    
    func checkBusXMLVersion(data: NSString) -> String {
        var xmlDom = SWXMLHash.parse(data)
        var rootTag: String
    
        switch xmlDom.element!.name {
        case "WeekdayBus":
            rootTag = "WeekdayBus"
        case "WeekendBus":
            rootTag = "WeekendBus"
        default:
            return "1511" // default version code
        }
        
        return xmlDom[rootTag]["version"].element!.text!
    }
    
    func getBusDataFromServer(type: BusTimeType, version: String?) {
        var url: NSURL
        var param: String = ""
        
        if version != nil {
            param = "?version=" + version!
        }
        
        switch type {
        case BusTimeType.SixwayWeekday:
            url = NSURL(string: Util.BusSixwayWeekdaysURL + param)!
        case BusTimeType.SixwayWeekend:
            url = NSURL(string: Util.BusSixwayWeekendURL + param)!
        case BusTimeType.SchoolWeekday:
            url = NSURL(string: Util.BusSchoolWeekdaysURL + param)!
        case BusTimeType.SchoolWeekend:
            url = NSURL(string: Util.BusSchoolWeekendURL + param)!
        }
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url, completionHandler:
            {(data: NSData!, response:NSURLResponse!, error:NSError!) -> Void in
                var xmlDom = SWXMLHash.parse(data)
                var rootTag: String
                
                if (xmlDom["WeekdayBus"].element != nil) {
                    rootTag = "WeekdayBus"
                } else if (xmlDom["WeekendBus"].element != nil) {
                    rootTag = "WeekendBus"
                } else {
                    return
                }
                
                if xmlDom[rootTag]["vResult"].element != nil {
                    // case: do not need to update xml
                    println("Already Exist proper DATA")
                } else {
                    switch response.URL!.path!.componentsSeparatedByString("HandongServer")[1] {
                    case Util.BusSixwayWeekdaysURL.componentsSeparatedByString("HandongServer")[1]:
                        Util.saveFile(Util.SixwayWeekdayBusFilename, data: data)
                    case Util.BusSixwayWeekendURL.componentsSeparatedByString("HandongServer")[1]:
                        Util.saveFile(Util.SixwayWeekendBusFilename, data: data)
                    case Util.BusSchoolWeekdaysURL.componentsSeparatedByString("HandongServer")[1]:
                        Util.saveFile(Util.SchoolWeekdayBusFilename, data: data)
                    case Util.BusSchoolWeekendURL.componentsSeparatedByString("HandongServer")[1]:
                        Util.saveFile(Util.SchoolWeekendBusFilename, data: data)
                    default:
                        break
                    }
                }
        })
        dataTask.resume()
    }
}