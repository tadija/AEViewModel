//
//  FormViewModel.swift
//  AETableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AETable

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
    var sections: [Section] = [
        UserInfo(),
        UserCredentials(),
        Action()
    ]
    
    // MARK: Sections
    
    struct UserInfo: Section {
        
        // MARK: Section
        
        var header: String?
        var footer: String?
        var items: [Item] = [
            FirstName(),
            LastName()
        ]
        
        // MARK: Items
        
        struct FirstName: Item {
            let identifier = ItemType.firstname.rawValue
            var data: ItemData? = BasicItemData(title: "First Name")
            var table: Table?
        }
        
        struct LastName: Item {
            let identifier = ItemType.lastname.rawValue
            var data: ItemData? = BasicItemData(title: "Last Name")
            var table: Table?
        }
        
    }
    
    struct UserCredentials: Section {
        
        // MARK: Section
        
        var header: String?
        var footer: String?
        var items: [Item] = [
            Username(),
            Password()
        ]
        
        // MARK: Items
        
        struct Username: Item {
            let identifier = ItemType.username.rawValue
            var data: ItemData? = BasicItemData(title: "Username")
            var table: Table?
        }
        struct Password: Item {
            let identifier = ItemType.password.rawValue
            var data: ItemData? = BasicItemData(title: "Password")
            var table: Table?
        }
        
    }
    
    struct Action: Section {
        
        // MARK: Section
        
        var header: String?
        var footer: String?
        var items: [Item] = [
            Accept(),
            Register()
        ]
        
        // MARK: Items
        
        struct Accept: Item {
            let identifier = ItemType.accept.rawValue
            var data: ItemData? = BasicItemData(title: "Accept Terms")
            var table: Table?
        }
        
        struct Register: Item {
            let identifier = ItemType.register.rawValue
            var data: ItemData? = BasicItemData(title: "Register")
            var table: Table?
        }
        
    }
    
}
