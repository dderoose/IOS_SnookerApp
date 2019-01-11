//
//  User.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 11/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
class User: NSObject {
    
    //properties
    var id: String?
    var username: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @username, @email, @password, and @confirmPassword parameters
    
    init(username: String, email: String, password: String, confirmPassword: String) {
        
        self.username = username
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        
    }
}
