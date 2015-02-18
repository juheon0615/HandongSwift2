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
    var docsDir: String = Util.getDocumentDirectory()
    var sixwayBusWeekendXMLFile: String?
    var sixwayBusWeekdayXMLFile: String?
    var schoolBusWeekendXMLFile: String?
    var schoolBusWeekdayXMLFile: String?
    var deliveryXMLFile: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // loading image rotation
        var rotationAni = CABasicAnimation()
        rotationAni.keyPath = "transform.rotation.z";
        rotationAni.toValue = NSNumber(double: M_PI * 2)
        rotationAni.duration = 2
        rotationAni.cumulative = true
        rotationAni.repeatCount = Float.infinity
        
        loadingImg.layer.addAnimation(rotationAni, forKey: "rotationAnimation")
        
        
        // get Main Bus time table
        self.getMainBusInfo()
        
        
        // get Bus Time Table
        self.getBusInfo()
        
        
        // get Delivery Food Info
        self.getDeliveryInfo()
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
    
    func getBusInfo() {
        sixwayBusWeekdayXMLFile = docsDir.stringByAppendingPathComponent(Util.SixwayWeekdayBusFilename)
        sixwayBusWeekendXMLFile = docsDir.stringByAppendingPathComponent(Util.SixwayWeekendBusFilename)
        schoolBusWeekdayXMLFile = docsDir.stringByAppendingPathComponent(Util.SchoolWeekdayBusFilename)
        schoolBusWeekendXMLFile = docsDir.stringByAppendingPathComponent(Util.SchoolWeekendBusFilename)
        
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
        
        let dataTask = session.dataTaskWithURL(url, completionHandler: getBusInfoAndSave)
        dataTask.resume()
    }
    
    func getBusInfoAndSave(data: NSData!, response:NSURLResponse!, error:NSError!) -> Void {
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
            if xmlDom[rootTag]["vResult"].element!.text! == "noChange" {
                println("Already Exist proper DATA")
            } else if xmlDom[rootTag]["vResult"].element!.text! == "change" {
                // remove bus files
                switch response.URL!.path!.componentsSeparatedByString("HandongServer")[1] {
                case Util.BusSixwayWeekdaysURL.componentsSeparatedByString("HandongServer")[1]:
                    Util.removeFile(Util.SixwayWeekdayBusFilename)
                case Util.BusSixwayWeekendURL.componentsSeparatedByString("HandongServer")[1]:
                    Util.removeFile(Util.SixwayWeekendBusFilename)
                case Util.BusSchoolWeekdaysURL.componentsSeparatedByString("HandongServer")[1]:
                    Util.removeFile(Util.SchoolWeekdayBusFilename)
                case Util.BusSchoolWeekendURL.componentsSeparatedByString("HandongServer")[1]:
                    Util.removeFile(Util.SchoolWeekendBusFilename)
                default:
                    break
                }
                
                // reload data from SERVER
                let url = NSURL(string: response.URL!.scheme! + response.URL!.host! + response.URL!.path!)!
                let session = NSURLSession.sharedSession()
                
                let dataTask = session.dataTaskWithURL(url, completionHandler: getBusInfoAndSave)
                dataTask.resume()
                
                println("Bus Info Data Changed. renew it")
            }
        } else if xmlDom[rootTag].element != nil {
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
        } else {
            // case for ERROR MESSAGE or other unFormed Messages.
        }
    }
    
    func getMainBusInfo() {
        var urlSix: NSURL
        var urlSchool: NSURL
        
        var mainBus = MainBusModel.sharedInstance
        
        if Util.isWeekendToday() {
            // case for weekend
            urlSchool = NSURL(string: Util.MainBusSchoolWeekendURL)!
            urlSix = NSURL(string: Util.MainBusSixwayWeekendURL)!
        } else {
            // case for weekdays
            urlSchool = NSURL(string: Util.MainBusSchoolWeekdayURL)!
            urlSix = NSURL(string: Util.MainBusSixwayWeekdayURL)!
        }
        
        let session = NSURLSession.sharedSession()
        let dataTaskSchool = session.dataTaskWithURL(urlSchool, completionHandler:
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
                
                let allBus = xmlDom[rootTag]["Bus"].all
                for item in allBus {
                    mainBus.toSchool.append(
                        BusModel(
                            six: item["six"].element!.text!,
                            hwan: item["hwan"].element!.text!,
                            school: item["school"].element!.text!))
                }
                
                if allBus.count < 3 {
                    for i in allBus.count ..< 3 {
                        mainBus.toSchool.append(BusModel(six: "-", hwan: "-", school: "-"))
                    }
                }
        })
        dataTaskSchool.resume()
        
        let dataTaskSix = session.dataTaskWithURL(urlSix, completionHandler:
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
                
                let allBus = xmlDom[rootTag]["Bus"].all
                for item in allBus {
                    mainBus.toSix.append(
                        BusModel(
                            six: item["six"].element!.text!,
                            hwan: item["hwan"].element!.text!,
                            school: item["school"].element!.text!))
                }
                
                if allBus.count < 3 {
                    for i in allBus.count ..< 3 {
                        mainBus.toSix.append(BusModel(six: "-", hwan: "-", school: "-"))
                    }
                }
        })
        dataTaskSix.resume()
    }
    
    func getDeliveryInfo() {
        deliveryXMLFile = Util.readFile(Util.DeliveryFoodFilename)
        
        var version: String? = nil
        if deliveryXMLFile != nil {
            version = self.checkDeliveryFoodXMLVersion(deliveryXMLFile!)
        }
        getDeliveryFoodDataFromServer(version)
    }
    
    func checkDeliveryFoodXMLVersion(data: NSString) -> String {
        let xmlDom = SWXMLHash.parse(data)
        
        return xmlDom["delivery"]["version"].element!.text!
    }
    func checkDeliveryDetailXMLVersion(data: NSString) -> String {
        let xmlDom = SWXMLHash.parse(data)
        
        return xmlDom["yasick"]["version"].element!.text!
    }
    
    func getDeliveryFoodDataFromServer(version: String?) {
        var param = (version != nil ? "?version="+version! : "")
        
        let url = NSURL(string: Util.DeliveryFoodURL + param)!
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url, completionHandler: getDeliveryFoodInfoAndSave)
        dataTask.resume()
    }
    
    func getDeliveryFoodInfoAndSave(data: NSData!, response:NSURLResponse!, error:NSError!) -> Void {
        var xmlDom = SWXMLHash.parse(data)
        
        if xmlDom["delivery"]["vResult"].element != nil {
            // case: do not need to update xml
            if xmlDom["delivery"]["vResult"].element!.text! == "noChange" {
                println("Already Exist proper DATA")
                xmlDom = SWXMLHash.parse(Util.readFile(Util.DeliveryFoodFilename)!)
            } else if xmlDom["delivery"]["vResult"].element!.text! == "change" {
                // remove previous file
                Util.removeFile(Util.DeliveryFoodFilename)
                
                // get new data from SERVER
                let url = NSURL(string: response.URL!.scheme! + response.URL!.host! + response.URL!.path!)!
                let session = NSURLSession.sharedSession()
                
                let dataTask = session.dataTaskWithURL(url, completionHandler: getDeliveryFoodInfoAndSave)
                dataTask.resume()
                
                println("Delivery Food Data Changed. renew it")
                return
            }
        } else {
            if xmlDom["delivery"].element != nil {
                Util.saveFile(Util.DeliveryFoodFilename, data: data)
            } else {
                return
            }
        }
        
        // get each store's data
        for store in xmlDom["delivery"]["information"].all {
            let file = Util.readFile(Util.DeliveryDetailFilename(store["id"].element!.text!))
            
            var param = ""
            if file != nil {
                let xmlDom = SWXMLHash.parse(file!)
                param += "?version=" + xmlDom["yasick"]["version"].element!.text!
            }
            
            let url = NSURL(string: Util.DeliveryDetailURL(store["id"].element!.text!) + param)!
            let session = NSURLSession.sharedSession()
            
            let dataTask = session.dataTaskWithURL(url, completionHandler: getEachDeliveryInfoAndSave)
            dataTask.resume()
        }
    }
    
    func getEachDeliveryInfoAndSave(data: NSData!, response:NSURLResponse!, error:NSError!) -> Void {
        var xmlDom = SWXMLHash.parse(data)
        
        let id = response.URL!.path!.componentsSeparatedByString("/").last!.componentsSeparatedByString("get").last!.componentsSeparatedByString(".jsp").first!
        
        if xmlDom["yasick"]["vResult"].element != nil {
            // case: do not need to update xml
            if xmlDom["yasick"]["vResult"].element!.text! == "noChange" {
                println("Already Exist proper DATA")
                xmlDom = SWXMLHash.parse(Util.readFile(Util.DeliveryFoodFilename)!)
            } else if xmlDom["yasick"]["vResult"].element!.text! == "change" {
                // remove previous file
                Util.removeFile(Util.DeliveryDetailFilename(id))
                
                // get new data from SERVER
                let url = NSURL(string: response.URL!.scheme! + response.URL!.host! + response.URL!.path!)!
                let session = NSURLSession.sharedSession()
                
                let dataTask = session.dataTaskWithURL(url, completionHandler: getEachDeliveryInfoAndSave)
                dataTask.resume()
                
                println("Delivery Food Data Changed. renew it")
                return
            }
        } else {
            if xmlDom["yasick"].element != nil {
                Util.saveFile(Util.DeliveryDetailFilename(id), data: data)
            } else {
                return
            }
        }
        
        Util.makeImageDirectory(id)
        
        for menu in xmlDom["yasick"]["mainMenu"].all {
            Util.checkAndDownloadImage(id, urlString: menu["photo"].element!.text!)
        }
    }
}