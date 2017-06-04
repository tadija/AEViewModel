//
//  FormViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

struct Form {
    struct Table: TableViewModel {
        let title = "Registration"
        var sections: [SectionViewModel] = [
            Section.UserInfo(),
            Section.UserCredentials(),
            Section.Register()
        ]
    }
    struct Section {
        struct UserInfo: SectionViewModel {
            var items: [ItemViewModel] = [
                Item.FirstName(),
                Item.LastName()
            ]
            struct Item {
                struct FirstName: ItemViewModel {
                    static let identifier = "firstname"
                    var model: ItemModel = BasicItemModel(title: "First Name")
                    var table: TableViewModel?
                }
                
                struct LastName: ItemViewModel {
                    static let identifier = "lastname"
                    var model: ItemModel = BasicItemModel(title: "Last Name")
                    var table: TableViewModel?
                }
            }
        }
        struct UserCredentials: SectionViewModel {
            var items: [ItemViewModel] = [
                Item.Username(),
                Item.Password()
            ]
            struct Item {
                struct Username: ItemViewModel {
                    static let identifier = "username"
                    var model: ItemModel = BasicItemModel(title: "Username")
                    var table: TableViewModel?
                }
                
                struct Password: ItemViewModel {
                    static let identifier = "password"
                    var model: ItemModel = BasicItemModel(title: "Password")
                    var table: TableViewModel?
                }
            }
        }
        struct Register: SectionViewModel {
            var items: [ItemViewModel] = [
                Item.Accept(),
                Item.Register()
            ]
            struct Item {
                struct Accept: ItemViewModel {
                    static let identifier = "accept"
                    var model: ItemModel = BasicItemModel(title: "Accept Terms")
                    var table: TableViewModel?
                }
                
                struct Register: ItemViewModel {
                    static let identifier = "register"
                    var model: ItemModel = BasicItemModel(title: "Register")
                    var table: TableViewModel?
                }
            }
        }
    }
}
