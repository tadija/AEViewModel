//
//  ExampleViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

struct Example {
    struct Table: TableViewModel {
        let title = "Example"
        var sections: [SectionViewModel] = [
            Section.General()
        ]
    }
    struct Section {
        struct General: SectionViewModel {
            var items: [ItemViewModel] = [
                Item.Registration()
            ]
            struct Item {
                struct Registration: ItemViewModel {
                    static let identifier = "form"
                    var model: ItemModel = BasicItemModel(title: "Form", detail: "Static Table View Model")
                    var table: TableViewModel? = Form.Table()
                }
            }
        }
    }
}
