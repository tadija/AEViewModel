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
            var child: ViewModel?
        }
        
        struct LastName: Item {
            let identifier = ItemType.lastname.rawValue
            var data: ItemData? = BasicItemData(title: "Last Name")
            var child: ViewModel?
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
            var child: ViewModel?
        }
        struct Password: Item {
            let identifier = ItemType.password.rawValue
            var data: ItemData? = BasicItemData(title: "Password")
            var child: ViewModel?
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
            var child: ViewModel?
        }
        
        struct Register: Item {
            let identifier = ItemType.register.rawValue
            var data: ItemData? = BasicItemData(title: "Register")
            var child: ViewModel?
        }
        
    }
    
}
