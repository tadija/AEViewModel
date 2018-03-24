/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct ExampleViewModel: ViewModel {
    struct Id {
        static let form = "form"
        static let settings = "settings"
        static let github = "github"
    }

    var title: String? = "Example"
    var sections: [Section] = [BasicSection(items: [
        BasicItem(identifier: Id.form, title: "Form", detail: "Static Table View Model"),
        BasicItem(identifier: Id.settings, title: "Settings", detail: "JSON Table View Model"),
        BasicItem(identifier: Id.github, title: "Github", detail: "Trending Swift Repos")
        ])
    ]
}
