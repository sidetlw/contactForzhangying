//
//  model.swift
//  contact
//
//  Created by test on 11/24/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import Foundation

class TodoModel:NSObject {
    var imageUrl:String
    var name:String
    var gender:String
    var phoneNumber:String
    
    init(imageUrl:String,name:String,gender:String,phoneNumber:String) {
        self.imageUrl = imageUrl
        self.name = name
        self.gender = gender
        self.phoneNumber = phoneNumber
    }
}
