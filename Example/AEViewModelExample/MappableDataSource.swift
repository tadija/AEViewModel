/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel
import Mappable

typealias MappableTable = MappableDataSource

struct MappableDataSource: DataSource, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case title
        case sections
    }
    
    // MARK: Table
    
    var title: String
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
        case id
        case data
    }
    
    // MARK: Item
    
    let identifier: String
    var model: ViewModel?
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        identifier = try map.value(forKey: Key.id.rawValue)
        model = try? map.mappable(forKey: Key.data.rawValue) as MappableItemData
    }
    
}

struct MappableItemData: ViewModel, Mappable {
    
    // MARK: Types
    
    enum Key: String {
        case title
        case detail
        case image
        case table
        case custom
    }
    
    // MARK: Model
    
    let title: String?
    let detail: String?
    let image: String?
    let submodel: DataSource?
    let custom: [String : Any]?
    
    // MARK: Mappable
    
    init(map: [String : Any]) throws {
        title = try? map.value(forKey: Key.title.rawValue)
        detail = try? map.value(forKey: Key.detail.rawValue)
        image = try? map.value(forKey: Key.image.rawValue)
        submodel = try? map.mappable(forKey: Key.table.rawValue) as MappableDataSource
        custom = try? map.value(forKey: Key.custom.rawValue)
    }
    
}

/// - Note: WIP

struct SettingsViewModel: ViewModel, Codable {
    let title: String?
    let detail: String?
    let image: String?
    var submodel: SettingsDataSource?
//    let custom: [String : String]?
    
    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case title, detail, image, table, custom
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        detail = try container.decodeIfPresent(String.self, forKey: .detail)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        submodel = try container.decodeIfPresent(SettingsDataSource.self, forKey: .table)
//        custom = try container.decodeIfPresent([String : String].self, forKey: .custom)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(detail, forKey: .detail)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(submodel, forKey: .table)
//        try container.encodeIfPresent(custom, forKey: .custom)
    }
}
struct SettingsItem: Item, Codable {
    let identifier: String
    var model: ViewModel?

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id, data
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .id)
        model = try container.decode(SettingsViewModel.self, forKey: .data)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .id)
        try container.encode(model, forKey: .data)
    }
}
struct SettingsSection: Section, Codable {
    var header: String?
    var footer: String?
    var items: [Item]

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case header, footer, items
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        header = try container.decodeIfPresent(String.self, forKey: .header)
        footer = try container.decodeIfPresent(String.self, forKey: .footer)
        items = try container.decode([SettingsItem].self, forKey: .items)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(header, forKey: .header)
        try container.encodeIfPresent(footer, forKey: .footer)
        try container.encode(items, forKey: .items)
    }
}
struct SettingsDataSource: DataSource, Codable {
    var title: String
    var sections: [Section]

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case title, sections
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        sections = try container.decode([SettingsSection].self, forKey: .sections)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(sections, forKey: .sections)
    }
}
