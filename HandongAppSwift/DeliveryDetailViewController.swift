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
        
        var itemYPos = 35.0 // margin top
        let xMargin = 8.0
        let labelXPos = xMargin + ShopInfoHeaderLabel.width + 5.0
        
        
        // set store info
        let holiday = ShopInfoHeaderLabel(x: xMargin, y: itemYPos, text: "휴무일 정보")
        self.scrollView.addSubview(holiday)
        
        let holidayLabel = ShopInfoLabel(x: labelXPos, y: itemYPos, text: storeInfo!.holiday)
        itemYPos += Double(holidayLabel.frame.height) + 3
        self.scrollView.addSubview(holidayLabel)
        
        let worktime = ShopInfoHeaderLabel(x: xMargin, y: itemYPos, text: "영업 시간")
        self.scrollView.addSubview(worktime)
        
        let worktimeLabel = ShopInfoLabel(x: labelXPos, y: itemYPos, text: storeInfo!.runTime)
        itemYPos += Double(worktimeLabel.frame.height) + 3
        self.scrollView.addSubview(worktimeLabel)
        
        let special = ShopInfoHeaderLabel(x: xMargin, y: itemYPos, text: "특이 사항")
        self.scrollView.addSubview(special)
        
        let specialLabel = ShopInfoLabel(x: labelXPos, y: itemYPos, text: storeInfo!.special)
        itemYPos += Double(specialLabel.frame.height)
        self.scrollView.addSubview(specialLabel)
        
        
        // add components in Scroll View
        let screenWidth = Double(UIScreen.mainScreen().applicationFrame.width)
        itemYPos += 5 // set margin
        
        var frame = CGRect(x: 8, y: itemYPos, width: 80, height: 21)
        var menuTitleLabel = UILabel(frame: frame)
        menuTitleLabel.font = UIFont(name: menuTitleLabel.font.fontName, size: 16)
        menuTitleLabel.text = "메뉴"
        itemYPos += 24
        
        frame = CGRect(x: 8, y: CGFloat(itemYPos), width: CGFloat(screenWidth - 8*2), height: 1)
        var menuTitleHorView = UIView(frame: frame)
        menuTitleHorView.backgroundColor = UIColor.blackColor()
        itemYPos += 5
        
        self.scrollView.addSubview(menuTitleLabel)
        self.scrollView.addSubview(menuTitleHorView)
        
        // add Main Menu
        for i in 0 ..< self.storeInfo!.mainMenus.count {
            let mainMenuImage = MainMenuUIImageView(index: i, itemYPos: Double(itemYPos), image: self.store!.id + "/" + self.storeInfo!.mainMenus[i].photo)
            self.scrollView.addSubview(mainMenuImage)
            
            let mainMenuName = MainMenuNameLabel(index: i, itemYPos: Double(itemYPos), text: self.storeInfo!.mainMenus[i].name)
            self.scrollView.addSubview(mainMenuName)
            
            let mainMenuPrice = MainMenuPriceLabel(index: i, itemYPos: Double(itemYPos), text: self.storeInfo!.mainMenus[i].price)
            self.scrollView.addSubview(mainMenuPrice)
        }
        itemYPos += (self.storeInfo!.mainMenus.count > 2 ? 360 : 180)
        
        
        let divBar = MenuDivideBarView(margin: 5.0, yPos: itemYPos)
        self.scrollView.addSubview(divBar)
        itemYPos += 5.0
        // Add ALL Menu
        for i in 0 ..< self.storeInfo!.menus.count {
            let itemView = MenuItemView(margin: 5.0, yPos: itemYPos, item: self.storeInfo!.menus[i])
            self.scrollView.addSubview(itemView)
            itemYPos += Double(itemView.frame.height + 5)
            
            let divBar = MenuDivideBarView(margin: 5.0, yPos: itemYPos)
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