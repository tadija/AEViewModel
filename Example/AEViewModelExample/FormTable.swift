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
        case firstname
        case lastname
        case username
        case password
        case accept
        case register
    }
    
    // MARK: Table
    
    let title = "Registration"
    var sections: [Section]
    
    init() {
        let firstName = BasicItem(identifier: ItemType.firstname.rawValue, title: "First Name")
        let lastName = BasicItem(identifier: ItemType.lastname.rawValue, title: "Last Name")
        let userInfo = BasicSection(items: [firstName, lastName])
        
        let username = BasicItem(identifier: ItemType.username.rawValue, title: "Username")
        let password = BasicItem(identifier: ItemType.password.rawValue, title: "Password")
        let userCredentials = BasicSection(items: [username, password])
        
        let accept = BasicItem(identifier: ItemType.accept.rawValue, title: "Accept")
        let register = BasicItem(identifier: ItemType.register.rawValue, title: "Register")
        let action = BasicSection(items: [accept, register])
        
        sections = [userInfo, userCredentials, action]
    }
    
}
