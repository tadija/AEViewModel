//
//  FormViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

struct FormTable: TableViewModel {
    let title = "Registration"
    var sections: [SectionViewModel] = [
        UserInfoSection(),
        UserCredentialsSection(),
        RegisterSection()
    ]
}

struct UserInfoSection: SectionViewModel {
    var items: [ItemViewModel] = [
        FirstNameItem(),
        LastNameItem()
    ]
    
    struct FirstNameItem: ItemViewModel {
        static let identifier = "firstname"
        var model: ItemModel = BasicItemModel(title: "First Name")
        var table: TableViewModel?
    }
    
    struct LastNameItem: ItemViewModel {
        static let identifier = "lastname"
        var model: ItemModel = BasicItemModel(title: "Last Name")
        var table: TableViewModel?
    }
}

struct UserCredentialsSection: SectionViewModel {
    var items: [ItemViewModel] = [
        UsernameItem(),
        PasswordItem()
    ]
    
    struct UsernameItem: ItemViewModel {
        static let identifier = "username"
        var model: ItemModel = BasicItemModel(title: "Username")
        var table: TableViewModel?
    }
    
    struct PasswordItem: ItemViewModel {
        static let identifier = "password"
        var model: ItemModel = BasicItemModel(title: "Password")
        var table: TableViewModel?
    }
}

struct RegisterSection: SectionViewModel {
    var items: [ItemViewModel] = [
        AcceptItem(),
        RegisterItem()
    ]
    
    struct AcceptItem: ItemViewModel {
        static let identifier = "accept"
        var model: ItemModel = BasicItemModel(title: "Accept Terms")
        var table: TableViewModel?
    }
    
    struct RegisterItem: ItemViewModel {
        static let identifier = "register"
        var model: ItemModel = BasicItemModel(title: "Register")
        var table: TableViewModel?
    }
}
