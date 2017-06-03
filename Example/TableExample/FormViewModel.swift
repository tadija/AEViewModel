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
        UserCredentialsSection()
    ]
}

struct UserInfoSection: SectionViewModel {
    var items: [ItemViewModel] = [
        FirstNameItem(),
        LastNameItem()
    ]
    
    struct FirstNameItem: ItemViewModel {
        let identifier = "firstname"
        var model: ItemModel = BasicItemModel(title: "First Name")
        var table: TableViewModel?
    }
    
    struct LastNameItem: ItemViewModel {
        let identifier = "lastname"
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
        let identifier = "username"
        var model: ItemModel = BasicItemModel(title: "Username")
        var table: TableViewModel?
    }
    
    struct PasswordItem: ItemViewModel {
        let identifier = "password"
        var model: ItemModel = BasicItemModel(title: "Password")
        var table: TableViewModel?
    }
}
