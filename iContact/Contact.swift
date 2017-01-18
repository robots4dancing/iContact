//
//  Contact.swift
//  iContact
//
//  Created by ANI on 1/18/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit

class Contact: NSObject {
    
    var firstName       :String!
    var lastName        :String!
    var phoneNum        :String!
    var email           :String!
    
    var fullNameByFirst :String! {
        return "\(firstName), \(lastName)"
    }
    var fullNameByLast  :String! {
        return "\(lastName), \(firstName)"
    }
    
    init(firstName: String, lastName: String, phoneNum: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNum = phoneNum
        self.email = email
        
    }
}
