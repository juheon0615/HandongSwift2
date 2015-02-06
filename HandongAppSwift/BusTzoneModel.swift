//
//  BusTzoneModel.swift
//  HandongAppSwift
//
//  Created by csee on 2015. 2. 3..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class BusTzoneModel {
    var timeSplit: String
    var tzone: String
    var bus: Array<BusModel>
    
    init(timeSplit: String, tzone: String, bus: Array<BusModel>) {
        self.timeSplit = timeSplit.uppercaseString
        self.tzone = tzone
        self.bus = bus
    }
}