//
//  ExampleViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

struct ExampleTable: Table {
    enum ItemType: String {
        case form
    }
    let title = "Example"
    var sections: [Section] = [
        General()
    ]
    struct General: Section {
        var items: [Item] = [
            Form()
        ]
        struct Form: Item {
            static let identifier = ItemType.form.rawValue
            var model: Model = BasicModel(title: "Form", detail: "Static Table View Model")
            var table: Table? = FormTable()
        }
    }
}
