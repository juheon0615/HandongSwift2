//
//  StoreDetailModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 11..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class StoreDetailModel {
    var holiday: String
    var runTime: String
    var special: String
    
    var mainMenus = Array<MainMenu>()
    var menus = Array<Menu>()
    
    init(xmlDom: XMLIndexer) {
        
        self.holiday = xmlDom["yasick"]["storeInfo"]["holiday"].element!.text!
        self.runTime = xmlDom["yasick"]["storeInfo"]["runTime"].element!.text!
        self.special = xmlDom["yasick"]["storeInfo"]["special"].element!.text!.stringByReplacingOccurrencesOfString("\\n", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let allMainMenu = xmlDom["yasick"]["mainMenu"].all
        for item in allMainMenu {
            let name = item["name"].element!.text!
            let price = item["price"].element!.text
            let photo = item["photo"].element!.text!.componentsSeparatedByString("/").last!
            mainMenus.append(MainMenu(name: name, price: price, photo: photo))
        }
        
        let allMenu = xmlDom["yasick"]["allMenu"].all
        for item in allMenu {
            let name = item["name"].element!.text
            let price = item["price"].element!.text
            let set = item["set"].element!.text
            menus.append(Menu(name: name, price: price, set: set))
        }
    }
    
    class MainMenu {
        var photo: String
        var name: String
        var price: String
        
        init(name: String, price: String?, photo: String) {
            self.name = name
            self.price = (price != nil && price! != "-" ? price! : "")
            
            let imagePath = photo
            let fileName = imagePath.componentsSeparatedByString("/").last!
            self.photo = fileName
        }
    }
    class Menu {
        var name: String
        var price: String
        var set: String
        
        init(name: String?, price: String?, set: String?) {
            self.name = (name != nil && name != "null" ? name!.stringByReplacingOccurrencesOfString("\\n", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil) : "")
            self.price = (price != nil && price != "null" ? price!.stringByReplacingOccurrencesOfString("\\n", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil) : "")
            self.set = (set != nil && set != "null" ? set!.stringByReplacingOccurrencesOfString("\\n", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil) : "")
        }
    }
}