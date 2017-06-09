//
//  SettingsViewModel.swift
//  TableExample
//
//  Created by Marko Tadić on 6/9/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table
import Mappable

struct MappableTable: Table, Mappable {
    let title: String
    var sections: [Section]
    
    init(map: [String : Any]) throws {
        title = try map.value(forKey: "title")
        sections = try map.mappableArray(forKey: "sections") as [MappableSection]
    }
}

struct MappableSection: Section, Mappable {
    var header: String?
    var footer: String?
    var items: [Item]
    
    init(map: [String : Any]) throws {
        header = try? map.value(forKey: "header")
        footer = try? map.value(forKey: "footer")
        items = try map.mappableArray(forKey: "items") as [MappableItem]
    }
}

struct MappableItem: Item, Mappable {
    static let identifier = "MappableItem"
    var model: Model?
    var table: Table?
    
    init(map: [String : Any]) throws {
        model = try? map.mappable(forKey: "model") as MappableModel
        table = try? map.value(forKey: "table")
    }
}

struct MappableModel: Model, Mappable {
    let title: String
    let detail: String
    let image: String
    
    init(map: [String : Any]) throws {
        title = try map.value(forKey: "title")
        detail = try map.value(forKey: "detail")
        image = try map.value(forKey: "image")
    }
}
