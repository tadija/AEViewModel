/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct ExampleDataSource: DataSource {
    
    struct Id {
        static let form = "form"
        static let settings = "settings"
        static let github = "github"
    }
    
    var sections: [Section] = [General()]
    
    struct General: Section {
        var items: [Item] = [Form(), Settings(), Github()]
        
        struct Form: Item {
            let identifier = Id.form
            var viewModel: ViewModel = BasicViewModel(title: "Form", detail: "Static Table View Model")
        }
        
        struct Settings: Item {
            let identifier = Id.settings
            var viewModel: ViewModel = BasicViewModel(title: "Settings", detail: "JSON Table View Model")
        }
        
        struct Github: Item {
            let identifier = Id.github
            var viewModel: ViewModel = BasicViewModel(title: "Github", detail: "Trending Swift Repos")
        }
    }
    
}
