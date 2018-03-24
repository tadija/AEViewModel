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

    var title: String? = "Example"
    var sections: [Section] = [General()]

    struct General: Section {
        var items: [Item] = [Form(), Settings(), Github()]
        
        struct Form: Item {
            let identifier = Id.form
            var model: Model = BasicModel(title: "Form", detail: "Static Table View Model")
        }
        
        struct Settings: Item {
            let identifier = Id.settings
            var model: Model = BasicModel(title: "Settings", detail: "JSON Table View Model")
        }
        
        struct Github: Item {
            let identifier = Id.github
            var model: Model = BasicModel(title: "Github", detail: "Trending Swift Repos")
        }
    }
}
