//
//  StaticModel.swift
//  TableExample
//
//  Created by Marko Tadić on 5/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation
import Table

extension Item {
    
    static var Static = Item("static") { `static` in
        `static`.title = "Static (Login)"
    }
    
    static var Dynamic = Item("dynamic") { i in
        i.title = "Dynamic (API?)"
    }
    
    static var Json = Item("json") { i in
        i.table = SettingsTVC.fromJson
        i.title = "JSON (Settings)"
    }
    
}

extension Section {
    
    static var General = Section("General") { s in
        s.items = [.Static, .Dynamic, .Json]
    }
    
}

extension Table {
    
    static let Example = Table { example in
        example.title = "Example"
        example.sections = [.General]
    }
    
}
