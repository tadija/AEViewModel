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
        
        struct Form: Item {
            let cellIdentifier = Cell.form.rawValue
            var viewModel: ViewModel = BasicViewModel(title: "Form", detail: "Static Table View Model")
        }
        
        struct Settings: Item {
            let cellIdentifier = Cell.settings.rawValue
            var viewModel: ViewModel = BasicViewModel(title: "Settings", detail: "JSON Table View Model")
        }
        
        struct Github: Item {
            let cellIdentifier = Cell.github.rawValue
            var viewModel: ViewModel = BasicViewModel(title: "Github", detail: "Trending Swift Repos")
        }
        
    }
    
}
