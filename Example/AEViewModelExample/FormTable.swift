/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct FormSection: Section {
    var items: [Item]
    var header: String?
}

struct FormTable: DataSource {
    
    // MARK: Types
    
    enum Cell: String {
        case username
        case password
        case accept
        case register
        
        var item: BasicItem {
            switch self {
            case .username:
                return BasicItem(identifier: rawValue, title: "Username")
            case .password:
                return BasicItem(identifier: rawValue, title: "Password")
            case .accept:
                return BasicItem(identifier: rawValue, title: "Accept Terms")
            case .register:
                return BasicItem(identifier: rawValue, title: "Register")
            }
        }
    }
    
    // MARK: Table

    var title: String? = "Registration"
    var sections: [Section]
    
    init() {
        let credentials = FormSection(items: [Cell.username.item, Cell.password.item], header: "Input")
        let actions = FormSection(items: [Cell.accept.item, Cell.register.item], header: "Actions")
        sections = [credentials, actions]
    }
    
}
