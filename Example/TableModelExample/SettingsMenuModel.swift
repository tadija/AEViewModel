//
//  SettingsMenuModel.swift
//  TableModelExample
//
//  Created by Marko Tadić on 5/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation
import TableModel

extension TableModel {
    
    static var settings: TableModel {
        var settings = TableModel("settings")
        settings.sections = [.user, .general]
        return settings
    }
    
}

extension Section {
    
    static var user: Section {
        var section = Section("profile")
        section.items = [.profile]
        return section
    }
    
    static var general: Section {
        var section = Section("general")
        section.items = [.airplane, .wifi]
        return section
    }
    
}

extension Item {
    
    static var profile: Item {
        var item = Item("profile")
        item.imageName = "IconGray"
        item.title = "Marko Tadic"
        item.detail = "Apple ID, iCloud, iTunes & App Store"
        return item
    }
    
    static var airplane: Item {
        var item = Item("airplane")
        item.imageName = "IconOrange"
        item.title = "Airplane Mode"
        return item
    }
    
    static var wifi: Item {
        var item = Item("wifi")
        item.imageName = "IconBlue"
        item.title = "Wi-Fi"
        item.detail = "Off"
        return item
    }
    
}
