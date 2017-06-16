//
//  FormTable.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel

struct FormTable: Table {
    
    // MARK: Types
    
    enum ItemType: String {
        case username
        case password
        case accept
        case register
    }
    
    // MARK: Table
    
    let title = "Registration"
    var sections: [Section]
    
    init() {
        let username = BasicItem(identifier: ItemType.username.rawValue, title: "Username")
        let password = BasicItem(identifier: ItemType.password.rawValue, title: "Password")
        let credentials = BasicSection(items: [username, password], header: "Input")
        
        let accept = BasicItem(identifier: ItemType.accept.rawValue, title: "Accept Terms")
        let register = BasicItem(identifier: ItemType.register.rawValue, title: "Register")
        let action = BasicSection(items: [accept, register], header: "Actions")
        
        sections = [credentials, action]
    }
    
}
