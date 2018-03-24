/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct FormViewModel: ViewModel {
    struct Id {
        static let username = "username"
        static let password = "password"
        static let accept = "accept"
        static let register = "register"
    }
    
    var title: String? = "Registration"
    var sections: [Section]

    init() {
        sections = [
            BasicSection(header: "Input",
                         items: [BasicItem(identifier: Id.username, title: "Username"),
                                 BasicItem(identifier: Id.password, title: "Password")]),
            BasicSection(header: "Actions",
                         items: [BasicItem(identifier: Id.accept, title: "Accept Terms"),
                                 BasicItem(identifier: Id.register, title: "Register")])
        ]
    }
}
