/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct ExampleViewModel: ViewModel {
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
