/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct FormSection: Section {
    let header: String
    var items: [Item]
}

struct FormTable: Table {
    
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
    
    var sections: [Section]
    
    init() {
        let credentials = FormSection(header: "Input", items: [Cell.username.item, Cell.password.item])
        let actions = FormSection(header: "Actions", items: [Cell.accept.item, Cell.register.item])
        sections = [credentials, actions]
    }
    
}
