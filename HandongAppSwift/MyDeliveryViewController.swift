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
    
    @IBOutlet weak var clearButton: UIButton!
    
    
    var selectedStore: StoreModel?

    let storeList = StoreListModel.sharedInstance
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    var favoriteList = Array<StoreModel>()
    var recentList = Array<StoreModel>()
    var timeList = Array<String>()
    
    override func viewDidLoad() {
        StoreListDAO.beginParsing(&storeList.storeList)
        
        // RECENT
        recentTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "rCell")
        recentTableView.dataSource = self
        recentTableView.delegate = self
        recentTableView.rowHeight = 44
        
        self.getRecentIDs()
        self.recentTableView.reloadData()
        
        // FAVORITE
        favoriteTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "fCell")
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        favoriteTableView.rowHeight = 44
        
        self.getFavoriteIDs()
        self.favoriteTableView.reloadData()
        
        clearButton.addTarget(self, action: "clerButtonClick:", forControlEvents: .TouchUpInside)
    }
    
    func getFavoriteIDs() {
        for store in storeList.storeList {
            let isFav = self.userDefaults.boolForKey(store.id)
            
            // case for Favorite Store ALREADY Checked
            if isFav == true {
                self.favoriteList.append(store)
            }
        }
    }
    
    func getRecentIDs() {
        let list = userDefaults.stringArrayForKey(Util.RecentCallKey) as Array<String>?
        
        if list == nil {
            return
        }
        
        // init list
        recentList.removeAll(keepCapacity: false)
        timeList.removeAll(keepCapacity: false)
        
        // add DATA
        for row in list! {
            let id = row.componentsSeparatedByString(Util.recentCallSpliter)[0]
            let time = row.componentsSeparatedByString(Util.recentCallSpliter)[1]
            
            for shop in storeList.storeList {
                if shop.id == id {
                    recentList.append(shop)
                    timeList.append(time)
                    
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
        if tableView == self.favoriteTableView {
            var cell:UITableViewCell! = self.favoriteTableView.dequeueReusableCellWithIdentifier("fCell") as UITableViewCell
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("fCell", owner: self, options: nil)[0] as UITableViewCell
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
            nameLabel.text = self.favoriteList[indexPath.row].name
            nameLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
            nameLabel.textAlignment = NSTextAlignment.Left
            cell.addSubview(nameLabel)
            
            let phoneLabel = UILabel(frame: CGRect(x: 5.0, y: 30.0, width: labelWidth/2, height: 10.0))
            phoneLabel.text = self.favoriteList[indexPath.row].phone
            phoneLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            phoneLabel.textAlignment = NSTextAlignment.Left
            phoneLabel.font = UIFont(name: phoneLabel.font.fontName, size: 11)
            cell.addSubview(phoneLabel)
            
            let rtLabel = UILabel(frame: CGRect(x: labelWidth/2, y: 30.0, width: labelWidth/2, height: 10.0))
            rtLabel.text = self.favoriteList[indexPath.row].runTime
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
            var cell:UITableViewCell! = self.recentTableView.dequeueReusableCellWithIdentifier("rCell") as UITableViewCell
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("rCell", owner: self, options: nil)[0] as UITableViewCell
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
            nameLabel.text = self.recentList[indexPath.row].name
            nameLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
            nameLabel.textAlignment = NSTextAlignment.Left
            cell.addSubview(nameLabel)
            
            let phoneLabel = UILabel(frame: CGRect(x: 5.0, y: 30.0, width: labelWidth/2, height: 10.0))
            phoneLabel.text = self.recentList[indexPath.row].phone
            phoneLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            phoneLabel.textAlignment = NSTextAlignment.Left
            phoneLabel.font = UIFont(name: phoneLabel.font.fontName, size: 11)
            cell.addSubview(phoneLabel)
            
            let timestampLabel = UILabel(frame: CGRect(x: labelWidth/2, y: 30.0, width: labelWidth/2, height: 10.0))
            timestampLabel.text = self.timeList[indexPath.row]
            timestampLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
            timestampLabel.textAlignment = NSTextAlignment.Right
            timestampLabel.font = UIFont(name: timestampLabel.font.fontName, size: 11)
            cell.addSubview(timestampLabel)
            
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
        if tableView == self.favoriteTableView {
            self.selectedStore = self.favoriteList[indexPath.row]
        } else {
            self.selectedStore = self.recentList[indexPath.row]
        }
        
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
        let selectedView = sender.superview as UITableViewCell
        var number: String
        var id: String
        
        if selectedView.reuseIdentifier == "fCell" {
            number = self.favoriteList[sender.tag].phone
            id = self.favoriteList[sender.tag].id
        } else {
            number = self.recentList[sender.tag].phone
            id = self.recentList[sender.tag].id
        }
        
        Util.makePhoneCall(number, storeID: id)
        
        self.getRecentIDs()
        recentTableView.reloadData()
    }

    func clerButtonClick(sender: UIButton!) {
        let list = userDefaults.stringArrayForKey(Util.RecentCallKey) as Array<String>?
        
        if list == nil {
            return
        }
        
        for row in list! {
            userDefaults.removeObjectForKey(Util.RecentCallKey)
        }
        recentList.removeAll(keepCapacity: false)
        recentTableView.reloadData()
    }
}