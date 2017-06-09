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
    
    // MARK: Types
    
    enum Key: String {
        case title
        case sections
    }
    
    // MARK: Table
    
    let title: String
    var sections: [Section]
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        title = try map.value(forKey: Key.title.rawValue)
        sections = try map.mappableArray(forKey: Key.sections.rawValue) as [MappableSection]
    }
}

struct MappableSection: Section, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case header
        case footer
        case items
    }
    
    // MARK: Section
    
    var header: String?
    var footer: String?
    var items: [Item]
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        header = try? map.value(forKey: Key.header.rawValue)
        footer = try? map.value(forKey: Key.footer.rawValue)
        items = try map.mappableArray(forKey: Key.items.rawValue) as [MappableItem]
    }
}

struct MappableItem: Item, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case model
        case table
    }
    
    // MARK: Item
    
    static let identifier = "MappableItem"
    var model: Model?
    var table: Table?
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        model = try? map.mappable(forKey: Key.model.rawValue) as MappableModel
        table = try? map.value(forKey: Key.table.rawValue)
    }
}

struct MappableModel: Model, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case title
        case detail
        case image
    }
    
    // MARK: Model
    
    let title: String
    let detail: String
    let image: String
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        title = try map.value(forKey: Key.title.rawValue)
        detail = try map.value(forKey: Key.detail.rawValue)
        image = try map.value(forKey: Key.image.rawValue)
    }
}
