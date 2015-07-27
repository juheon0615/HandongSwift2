//
//  OpTimeModel.swift
//  HandongAppSwift
//
//  Created by ghost on 2015. 7. 20..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class OpTime {
    var name: String
    var runtime: String
    var note: String
    
    init(name: String, runtime: String, note: String?){
        self.name = name
        self.runtime = runtime
        self.note = (note != nil ? note!:"")
    }
  
}