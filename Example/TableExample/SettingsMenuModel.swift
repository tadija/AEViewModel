//
//  SettingsMenuModel.swift
//  TableExample
//
//  Created by Marko Tadić on 5/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation
import Table

extension Table {
    
    static var settings: Table {
        var settings = Table("settings")
        settings.sections = [.user, .device]
        return settings
    }
    
}

extension Section {
    
    static var user: Section {
        var section = Section("user")
        section.items = [.profile]
        return section
    }
    
    static var device: Section {
        var section = Section("device")
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
