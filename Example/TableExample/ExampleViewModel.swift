//
//  ExampleViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

struct ExampleTable: Table {
    
    // MARK: Types
    
    enum ItemType: String {
        case form
        case settings
    }
    
    // MARK: Table
    
    let title = "Example"
    var sections: [Section] = [
        General()
    ]
    
    // MARK: Sections
    
    struct General: Section {
        
        // MARK: Section
        
        var header: String?
        var footer: String?
        var items: [Item] = [
            Form(),
            Settings()
        ]
        
        // MARK: Items
        
        struct Form: Item {
            static let identifier = ItemType.form.rawValue
            var model: Model? = BasicModel(title: "Form", detail: "Static Table View Model")
            var table: Table? = FormTable()
        }
        
        struct Settings: Item {
            static let identifier = ItemType.settings.rawValue
            var model: Model? = BasicModel(title: "Settings", detail: "JSON Table View Model")
            var table: Table? = MappableTable.Settings
        }
        
    }
    
}
