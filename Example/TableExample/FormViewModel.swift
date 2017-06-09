//
//  FormViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

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
            static let identifier = ItemType.firstname.rawValue
            var model: Model? = BasicModel(title: "First Name")
            var table: Table?
        }
        
        struct LastName: Item {
            static let identifier = ItemType.lastname.rawValue
            var model: Model? = BasicModel(title: "Last Name")
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
            static let identifier = ItemType.username.rawValue
            var model: Model? = BasicModel(title: "Username")
            var table: Table?
        }
        struct Password: Item {
            static let identifier = ItemType.password.rawValue
            var model: Model? = BasicModel(title: "Password")
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
            static let identifier = ItemType.accept.rawValue
            var model: Model? = BasicModel(title: "Accept Terms")
            var table: Table?
        }
        
        struct Register: Item {
            static let identifier = ItemType.register.rawValue
            var model: Model? = BasicModel(title: "Register")
            var table: Table?
        }
        
    }
    
}
