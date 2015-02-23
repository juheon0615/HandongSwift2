//
//  MyDeliveryViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 23..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class MyDeliveryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var recentTableView: UITableView!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    let storeList = StoreListModel.sharedInstance
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    var favoriteList = Array<StoreModel>()
    var recentList = Array<StoreModel>()
    var timeList = Array<String>()
    
    override func viewDidLoad() {
        self.beginParsing()
        
        self.getFavoriteIDs()
        self.getRecentIDs()
        
        self.favoriteTableView.reloadData()
        self.recentTableView.reloadData()
    }
    
    func getFavoriteIDs() {
        for store in storeList.storeList {
            let isFav: Bool? = self.userDefaults.valueForKey(store.id) as Bool?
            
            // case for Favorite Store ALREADY Checked
            if isFav != nil && isFav! == true {
                self.favoriteList.append(store)
            }
        }
    }
    
    func getRecentIDs() {
        let list = userDefaults.stringArrayForKey(Util.RecentCallKey) as Array<String>
        
        for row in list {
            let id = row.componentsSeparatedByString(Util.recentCallSpliter)[0]
            let time = row.componentsSeparatedByString(Util.recentCallSpliter)[1]
            
            for shop in storeList.storeList {
                if shop.id == id {
                    recentList.insert(shop, atIndex: 0)
                    timeList.insert(time, atIndex: 0)
                    
                    break
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.favoriteTableView {
            return self.favoriteList.count
        } else {
            return self.recentList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tavleView == self.favoriteTableView {
            var cell:UITableViewCell! = self.favoriteTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as UITableViewCell
            }
            
            // remove previous labels
            for view in cell.subviews {
                view.removeFromSuperview()
            }
            
            // make cell content
            let tableWidth = tableView.frame.width
            let labelWidth = (tableWidth-60)
            
            // name Text Label
            let nameLabel = UILabel(frame: CGRect(x: 5.0, y: 0.0, width: labelWidth, height: 30.0))
            nameLabel.text = self.storeList.storeList[indexPath.row].name
            nameLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
            nameLabel.textAlignment = NSTextAlignment.Left
            cell.addSubview(nameLabel)
            
            let phoneLabel = UILabel(frame: CGRect(x: 5.0, y: 30.0, width: labelWidth/2, height: 10.0))
            phoneLabel.text = self.storeList.storeList[indexPath.row].phone
            phoneLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            phoneLabel.textAlignment = NSTextAlignment.Left
            phoneLabel.font = UIFont(name: phoneLabel.font.fontName, size: 11)
            cell.addSubview(phoneLabel)
            
            let rtLabel = UILabel(frame: CGRect(x: labelWidth/2, y: 30.0, width: labelWidth/2, height: 10.0))
            rtLabel.text = self.storeList.storeList[indexPath.row].runTime
            rtLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            rtLabel.textAlignment = NSTextAlignment.Right
            rtLabel.font = UIFont(name: rtLabel.font.fontName, size: 11)
            cell.addSubview(rtLabel)
            
            let phoneButton = UIButton(frame: CGRect(x: labelWidth + 10, y: 5, width: 40, height: 40))
            phoneButton.setImage(UIImage(named: "phone_icon.png"), forState: .Normal)
            phoneButton.tag = indexPath.row
            phoneButton.addTarget(self, action: "callButtonClick:", forControlEvents: .TouchUpInside)
            cell.addSubview(phoneButton)
            
            cell.separatorInset.bottom = 1.0
            return cell
        } else {
            var cell:UITableViewCell! = self.recentTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as UITableViewCell
            }
            
            // remove previous labels
            for view in cell.subviews {
                view.removeFromSuperview()
            }
            
            // make cell content
            let tableWidth = tableView.frame.width
            let labelWidth = (tableWidth-60)
            
            // name Text Label
            let nameLabel = UILabel(frame: CGRect(x: 5.0, y: 0.0, width: labelWidth, height: 30.0))
            nameLabel.text = self.storeList.storeList[indexPath.row].name
            nameLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
            nameLabel.textAlignment = NSTextAlignment.Left
            cell.addSubview(nameLabel)
            
            let phoneLabel = UILabel(frame: CGRect(x: 5.0, y: 30.0, width: labelWidth/2, height: 10.0))
            phoneLabel.text = self.storeList.storeList[indexPath.row].phone
            phoneLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            phoneLabel.textAlignment = NSTextAlignment.Left
            phoneLabel.font = UIFont(name: phoneLabel.font.fontName, size: 11)
            cell.addSubview(phoneLabel)
            
            let rtLabel = UILabel(frame: CGRect(x: labelWidth/2, y: 30.0, width: labelWidth/2, height: 10.0))
            rtLabel.text = self.storeList.storeList[indexPath.row].runTime
            rtLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            rtLabel.textAlignment = NSTextAlignment.Right
            rtLabel.font = UIFont(name: rtLabel.font.fontName, size: 11)
            cell.addSubview(rtLabel)
            
            let phoneButton = UIButton(frame: CGRect(x: labelWidth + 10, y: 5, width: 40, height: 40))
            phoneButton.setImage(UIImage(named: "phone_icon.png"), forState: .Normal)
            phoneButton.tag = indexPath.row
            phoneButton.addTarget(self, action: "callButtonClick:", forControlEvents: .TouchUpInside)
            cell.addSubview(phoneButton)
            
            cell.separatorInset.bottom = 1.0
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedStore = self.storeList.storeList[indexPath.row]
        self.performSegueWithIdentifier("deliveryDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "deliveryDetailSegue" {
            var dstView = segue.destinationViewController as DeliveryDetailViewController
            dstView.store = self.selectedStore
        }
    }
    
    // call Button event handler
    func callButtonClick(sender: UIButton!) {
        Util.makePhoneCall(self.storeList.storeList[sender.tag].phone)
    }
    
    func beginParsing() {
        if self.storeList.storeList.count > 0 {
            // not first call.
            // do not need to read data
            return
        }
        
        let fileData = Util.readFile(Util.DeliveryFoodFilename)
        
        if fileData != nil {
            let xmlDom = SWXMLHash.parse(fileData!)
            
            for item in xmlDom["delivery"]["information"].all {
                let id = item["id"].element!.text!
                let name = item["name"].element!.text!
                let phone = item["phone"].element!.text
                let runTime = item["runTime"].element!.text
                let category = item["category"].element!.text
                
                self.storeList.storeList.append(StoreModel(id: id, name: name, phone: phone, runTime: runTime, category: category))
            }
        }
    }

}