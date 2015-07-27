//
//  ProfessorModel.swift
//  HandongAppSwift
//
//  Created by ghost on 2015. 7. 23..
//  Copyright (c) 2015년 GHOST. All rights reserved.
//

import Foundation

class Professor{
    var name: String
    var major: String
    var phone: String
    var email: String
    var office: String
    
    init (name: String, major: String, phone: String, email: String, office: String?){
        self.name = name
        self.major = major
        self.phone = phone
        self.email = email
        self.office = (office != nil ? office!:"")
    }
    
}