//
//  DdoSooneiController.swift
//  HandongAppSwift
//
//  Created by ghost on 2015. 7. 27..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class DdoSooneiController: UIViewController {
    
       
    
    @IBAction func OpenDdoSoonCafe(sender: AnyObject) {
        if let url = NSURL(string: "http://google.com") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func CallDdoSoon(sender:AnyObject){
        callNumber("01033135201")
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
}