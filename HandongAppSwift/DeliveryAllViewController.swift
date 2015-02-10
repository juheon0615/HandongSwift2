//
//  DeliveryViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 10..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class DeliveryAllViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let storeList = StoreListModel.sharedInstance
    
    @IBOutlet weak var storeListTableView: UITableView!
    
    override func viewDidLoad() {
        storeListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        storeListTableView.dataSource = self
        storeListTableView.delegate = self
        
        storeListTableView.rowHeight = 50
        
        self.beginParsing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeList.storeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = self.storeListTableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
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
        let nameLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: labelWidth, height: 30.0))
        nameLabel.text = self.storeList.storeList[indexPath.row].name
        nameLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        nameLabel.textAlignment = NSTextAlignment.Left
        cell.addSubview(nameLabel)
        
        let phoneLabel = UILabel(frame: CGRect(x: 0, y: 30.0, width: labelWidth/2, height: 10.0))
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
        phoneButton.addTarget(self, action: "callButtonPushed:", forControlEvents: .TouchUpInside)
        cell.addSubview(phoneButton)
        
        cell.separatorInset.bottom = 1.0
        return cell
    }
    
    // call Button event handler
    func callButtonPushed(sender: UIButton!) {
        let url = NSURL(string: self.storeList.storeList[sender.tag].phone)
        UIApplication.sharedApplication().openURL(url!)
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
            
            dispatch_async(dispatch_get_main_queue(), {
                self.storeListTableView.reloadData()
            })
        }
    }
}