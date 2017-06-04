//
//  FormViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

struct FormTable: TableViewModel {
    enum ItemType: String {
        case firstname
        case lastname
        case username
        case password
        case accept
        case register
    }
    let title = "Registration"
    var sections: [SectionViewModel] = [
        UserInfo(),
        UserCredentials(),
        Action()
    ]
    struct UserInfo: SectionViewModel {
        var items: [ItemViewModel] = [
            FirstName(),
            LastName()
        ]
        struct FirstName: ItemViewModel {
            static let identifier = ItemType.firstname.rawValue
            var model: ItemModel = BasicItemModel(title: "First Name")
            var table: TableViewModel?
        }
        struct LastName: ItemViewModel {
            static let identifier = ItemType.lastname.rawValue
            var model: ItemModel = BasicItemModel(title: "Last Name")
            var table: TableViewModel?
        }
    }
    struct UserCredentials: SectionViewModel {
        var items: [ItemViewModel] = [
            Username(),
            Password()
        ]
        struct Username: ItemViewModel {
            static let identifier = ItemType.username.rawValue
            var model: ItemModel = BasicItemModel(title: "Username")
            var table: TableViewModel?
        }
        struct Password: ItemViewModel {
            static let identifier = ItemType.password.rawValue
            var model: ItemModel = BasicItemModel(title: "Password")
            var table: TableViewModel?
        }
    }
    struct Action: SectionViewModel {
        var items: [ItemViewModel] = [
            Accept(),
            Register()
        ]
        struct Accept: ItemViewModel {
            static let identifier = ItemType.accept.rawValue
            var model: ItemModel = BasicItemModel(title: "Accept Terms")
            var table: TableViewModel?
        }
        
        struct Register: ItemViewModel {
            static let identifier = ItemType.register.rawValue
            var model: ItemModel = BasicItemModel(title: "Register")
            var table: TableViewModel?
        }
    }
}
