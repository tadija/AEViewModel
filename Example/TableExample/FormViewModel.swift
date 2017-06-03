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
        var model: ItemModel = Model()
        var table: TableViewModel?
        
        struct Model: ItemModel {
            let title = "First Name"
        }
    }
    
    struct LastNameItem: ItemViewModel {
        let identifier = "lastname"
        var model: ItemModel = Model()
        var table: TableViewModel?
        
        struct Model: ItemModel {
            let title = "Last Name"
        }
    }
}

struct UserCredentialsSection: SectionViewModel {
    var items: [ItemViewModel] = [
        UsernameItem(),
        PasswordItem()
    ]
    
    struct UsernameItem: ItemViewModel {
        let identifier = "username"
        var model: ItemModel = Model()
        var table: TableViewModel?
        
        struct Model: ItemModel {
            let title = "Username"
        }
    }
    
    struct PasswordItem: ItemViewModel {
        let identifier = "password"
        var model: ItemModel = Model()
        var table: TableViewModel?
        
        struct Model: ItemModel {
            let title = "Password"
        }
    }
}
