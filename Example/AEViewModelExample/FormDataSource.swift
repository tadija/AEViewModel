/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import AEViewModel

struct FormDataSource: DataSource {
    struct Id {
        static let username = "username"
        static let password = "password"
        static let accept = "accept"
        static let register = "register"
    }

    var title: String? = "Registration"
    var sections: [Section] = [Input(), Actions()]

    struct Input: Section {
        var header: String? = "Input"
        var items: [Item] = [BasicItem(identifier: Id.username, title: "Username"),
                             BasicItem(identifier: Id.password, title: "Password")]
    }

    struct Actions: Section {
        var header: String? = "Actions"
        var items: [Item] = [BasicItem(identifier: Id.accept, title: "Accept Terms"),
                             BasicItem(identifier: Id.register, title: "Register")]
    }

}
