//
//  ExampleViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

struct ExampleTable: TableViewModel {
    let title = "Example"
    var sections: [SectionViewModel] = [
        ExampleSection()
    ]
}

struct ExampleSection: SectionViewModel {
    var items: [ItemViewModel] = [
        FormItem()
    ]
}

struct FormItem: ItemViewModel {
    let identifier = "form"
    var model: ItemModel = FormModel()
    var table: TableViewModel?
}

struct FormModel: ItemModel {
    let title = "Form"
    let detail = "Static Table View Model"
}
