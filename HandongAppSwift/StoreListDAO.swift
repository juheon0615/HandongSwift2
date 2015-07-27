//
//  StoreListDAO.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 24..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class StoreListDAO {

    class func beginParsing(inout storeList: Array<StoreModel>) {
        if storeList.count > 0 {
            // not first call.
            // do not need to read data
            return
        }
        
        let fileData = Util.readFile(Util.DeliveryFoodFilename)
        
        if fileData != nil {
            let xmlDom = SWXMLHash.parse(fileData! as String)
            
            for item in xmlDom["delivery"]["information"].all {
                let id = item["id"].element!.text!
                let name = item["name"].element!.text!
                let phone = item["phone"].element!.text
                let runTime = item["runTime"].element!.text
                let category = item["category"].element!.text
                
                storeList.append(StoreModel(id: id, name: name, phone: phone, runTime: runTime, category: category))
            }
        }
    }
}