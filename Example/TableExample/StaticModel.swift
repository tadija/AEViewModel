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
    
    static let Example = Model("Example") { m in
        m.title = "Example"
        m.sections = [.General]
    }
    
}

extension Section {
    
    static var General = Section("General") { s in
        s.items = [.Static, .Dynamic, .Json]
    }
    
}

extension Item {
    
    static var Static = Item("static") { i in
        i.title = "Static (?)"
    }
    
    static var Dynamic = Item("dynamic") { i in
        i.title = "Dynamic (?)"
    }
    
    static var Json = Item("json") { i in
        i.model = SettingsTVC.MyModel
        i.title = "JSON (Settings)"
    }
    
}
