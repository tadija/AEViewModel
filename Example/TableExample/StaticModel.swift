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
    
    static var Dynamic = Item("dynamic") { dynamic in
        dynamic.title = "Dynamic (API?)"
    }
    
    static var Json = Item("json") { json in
        json.table = Table.Settings
        json.title = "JSON (Settings)"
    }
    
}

extension Section {
    
    static var General = Section("General") { general in
        general.items = [.Static, .Dynamic, .Json]
    }
    
}

extension Table {
    
    static let Example = Table { example in
        example.title = "Example"
        example.sections = [.General]
    }
    
    static let Settings: Table? = {
        guard
            let url = Bundle.main.url(forResource: "JsonModel", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let table = try? Table(jsonData: data)
        else {
            return nil
        }
        return table
    }()
    
}
