//
//  DeliveryDetailViewController.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 11..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation
import UIKit

class DeliveryDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var callButton: UIBarButtonItem!
    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var titleBarItem: UINavigationItem!
    
    @IBOutlet weak var holidayLabel: UILabel!
    @IBOutlet weak var specialLabel: UILabel!
    @IBOutlet weak var worktimeLabel: UILabel!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var menuTitleHorView: UIView!
    
    var store: StoreModel?
    var storeInfo: StoreDetailModel?
    
    var actInd = UIActivityIndicatorView()
    var favorite: Bool = false
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        Util.showActivityIndicatory(self.view, indicator: &self.actInd)
        checkFile()
        Util.hideActivityIndicator(&self.actInd)
    }
    
    func checkFile() {
        let file = Util.readFile(Util.DeliveryDetailFilename(store!.id))
        
        if file != nil {
            self.storeInfo = StoreDetailModel(xmlDom: SWXMLHash.parse(file!))
            self.displayData()
        }
    }
    
    func displayData() {
        self.titleBarItem.title = store!.name
        self.callButton.target = self
        self.callButton.action = "callButtonClick:"
        
        if self.userDefaults.boolForKey(store!.id) {
            self.favoriteButton.image = UIImage(named: "selected_star_small.png")
            favorite = true
        }
        
        self.favoriteButton.target = self
        self.favoriteButton.action = "favoriteButtonClick:"
        
        // set store info
        self.holidayLabel.text = storeInfo!.holiday
        self.worktimeLabel.text = storeInfo!.runTime
        self.specialLabel.numberOfLines = 0
        self.specialLabel.text = storeInfo!.special
        self.specialLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.specialLabel.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.specialLabel.sizeToFit()
        
        // add components in Scroll View
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        var itemYPos = self.specialLabel.frame.height + self.specialLabel.frame.origin.y
        itemYPos += 5 // set margin
        var frame = self.menuTitleLabel.frame
        frame.origin.y = itemYPos
        self.menuTitleLabel.frame = frame
        itemYPos += 24
        frame = self.menuTitleHorView.frame
        frame.origin.y = itemYPos
        self.menuTitleHorView.frame = frame
        itemYPos += 5
        
        // add Main Menu
        for i in 0 ..< self.storeInfo!.mainMenus.count {
            let mainMenuImage = MainMenuUIImageView(index: i, itemYPos: Double(itemYPos), image: self.store!.id + "/" + self.storeInfo!.mainMenus[i].photo)
            self.scrollView.addSubview(mainMenuImage)
            
            let mainMenuName = MainMenuNameLabel(index: i, itemYPos: Double(itemYPos), text: self.storeInfo!.mainMenus[i].name)
            self.scrollView.addSubview(mainMenuName)
            
            let mainMenuPrice = MainMenuPriceLabel(index: i, itemYPos: Double(itemYPos), text: self.storeInfo!.mainMenus[i].price)
            self.scrollView.addSubview(mainMenuPrice)
        }
        itemYPos += (self.storeInfo!.mainMenus.count > 2 ? 350 : 175)
        
        
        let divBar = MenuDivideBarView(margin: 5.0, yPos: Double(itemYPos))
        self.scrollView.addSubview(divBar)
        itemYPos += 5.0
        // Add ALL Menu
        for i in 0 ..< self.storeInfo!.menus.count {
            let itemView = MenuItemView(margin: 5.0, yPos: Double(itemYPos), item: self.storeInfo!.menus[i])
            self.scrollView.addSubview(itemView)
            itemYPos += itemView.frame.height + 2
            
            let divBar = MenuDivideBarView(margin: 5.0, yPos: Double(itemYPos))
            self.scrollView.addSubview(divBar)
            itemYPos += 5.0
        }
        
        // Loading END
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width, CGFloat(itemYPos))
    }
    
    func callButtonClick(sender: UIBarButtonItem) {
        let url = NSURL(string: self.store!.phone)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func favoriteButtonClick(sender: UIBarButtonItem) {
        if self.favorite {
            self.favorite = false
            self.userDefaults.removeObjectForKey(store!.id)
            self.favoriteButton.image = UIImage(named: "unselected_star_small.png")
        } else {
            self.favorite = true
            self.userDefaults.setBool(true, forKey: store!.id)
            self.favoriteButton.image = UIImage(named: "selected_star_small.png")
        }
        self.userDefaults.synchronize()
    }
}