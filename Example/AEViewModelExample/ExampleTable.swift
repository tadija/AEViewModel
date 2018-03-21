/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct ExampleTable: DataSource {
    
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

        /// - TODO: check later
        
        struct Form: Item {
            let identifier = Cell.form.rawValue
            var model: ViewModel? = BasicViewModel(title: "Form", detail: "Static Table View Model") //, child: FormTable())
        }
        
        struct Settings: Item {
            let identifier = Cell.settings.rawValue
            var model: ViewModel? = BasicViewModel(title: "Settings", detail: "JSON Table View Model") //, child: SettingsTable.fromJson)
        }
        
        struct Github: Item {
            let identifier = Cell.github.rawValue
            var model: ViewModel? = BasicViewModel(title: "Github", detail: "Trending Swift Repos") //, child: BasicTable())
        }
        
    }
    
}
