/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import AEViewModel

struct ExampleDataSource: DataSource {
    struct Id {
        static let cells = "cells"
        static let form = "form"
        static let settings = "settings"
        static let github = "github"
    }

    var title: String? = "Example"
    var sections: [Section] = [
        BasicSection(footer: "Default cells which are provided out of the box.", items: [
            BasicItem(identifier: Id.cells, title: "Cells")
        ]),
        BasicSection(header: "Demo", items: [
            BasicItem(identifier: Id.form, title: "Form", detail: "Static View Model"),
            BasicItem(identifier: Id.settings, title: "Settings", detail: "JSON View Model"),
            BasicItem(identifier: Id.github, title: "Github", detail: "Remote View Model")
        ])
    ]
}
