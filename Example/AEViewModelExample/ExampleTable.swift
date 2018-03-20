/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct ExampleTable: Table {
    
    // MARK: Types
    
    enum Cell: String {
        case form
        case settings
        case github
    }
    
    // MARK: Table
    
    var sections: [Section] = [
        General()
    ]
    
    // MARK: Sections
    
    struct General: Section {
        
        // MARK: Section
        
        var items: [Item] = [
            Form(),
            Settings(),
            Github()
        ]
        
        // MARK: Items
        
        struct Form: Item {
            let identifier = Cell.form.rawValue
            var data: ItemData? = BasicItemData(title: "Form", detail: "Static Table View Model",
                                                submodel: FormTable())
        }
        
        struct Settings: Item {
            let identifier = Cell.settings.rawValue
            var data: ItemData? = BasicItemData(title: "Settings", detail: "JSON Table View Model",
                                                submodel: SettingsTable.fromJson)
        }
        
        struct Github: Item {
            let identifier = Cell.github.rawValue
            var data: ItemData? = BasicItemData(title: "Github", detail: "Trending Swift Repos",
                                                submodel: BasicTable())
        }
        
    }
    
}
