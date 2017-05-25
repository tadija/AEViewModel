//
//  StaticModel.swift
//  TableExample
//
//  Created by Marko Tadić on 5/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation
import Table

extension Model {
    
    static let Settings = Model("settings") { m in
        m.sections = [.User, .Device]
    }
    
}

extension Section {
    
    static var User = Section("user") { s in
        s.items = [.Profile]
    }
    
    static var Device = Section("device") { s in
        s.items = [.Airplane, .Wifi]
    }
    
}

extension Item {
    
    static var Profile = Item("profile") { i in
        i.image = "IconGray"
        i.title = "Marko Tadic"
        i.detail = "Apple ID, iCloud, iTunes & App Store"
    }
    
    static var Airplane = Item("airplane") { i in
        i.image = "IconOrange"
        i.title = "Airplane Mode"
    }
    
    static var Wifi = Item("wifi") { i in
        i.image = "IconBlue"
        i.title = "Wi-Fi"
        i.detail = "Off"
    }
    
}
