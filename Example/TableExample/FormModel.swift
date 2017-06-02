//
//  FormModel.swift
//  TableExample
//
//  Created by Marko Tadić on 5/28/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

extension Table {
    
    static let Register = Table { table in
        table.title = "Register"
        table.sections = [.UserInfo, .UserCredentials]
    }
    
}

extension Section {
    
    static let UserInfo = Section("userinfo") { section in
        section.header = "User Info"
        section.items = [.FirstName, .LastName]
    }
    
    static let UserCredentials = Section("usercredentials") { section in
        section.header = "User Credentials"
        section.items = [.Username, .Password]
    }
    
}

extension Item {
    
    static let FirstName = Item("firstName") { item in
        item.title = "First name"
    }
    
    static let LastName = Item("lastName") { item in
        item.title = "Last name"
    }
    
    static let Username = Item("username") { item in
        item.title = "Username"
    }
    
    static let Password = Item("password") { item in
        item.title = "Password"
    }
    
}
