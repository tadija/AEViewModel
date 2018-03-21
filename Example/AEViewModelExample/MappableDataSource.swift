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

/// - Note: Replace with Codable later

/*

public struct BasicViewModel: ViewModel, Codable {
    public let title: String?
    public let detail: String?
    public let image: String?
    public var child: BasicDataSource?

    public init(title: String? = nil, detail: String? = nil, image: String? = nil, child: BasicDataSource? = nil) {
        self.title = title
        self.detail = detail
        self.image = image
        self.child = child
    }
}
public struct BasicItem: Item, Codable {
    public let identifier: String
    public var model: ViewModel?

    public init(identifier: String, model: ViewModel? = nil) {
        self.identifier = identifier
        self.model = model
    }

    public init(identifier: String,
                title: String? = nil, detail: String? = nil, image: String? = nil, child: BasicDataSource? = nil) {
        self.identifier = identifier
        self.model = BasicViewModel(title: title, detail: detail, image: image, child: child)
    }

    // MARK: Codable

    public enum CodingKeys: String, CodingKey {
        case identifier, model
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        model = try container.decode(BasicViewModel.self, forKey: .model)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(model, forKey: .model)
    }
}
public struct BasicSection: Section, Codable {
    public var items: [Item]

    public init(items: [Item] = [Item]()) {
        self.items = items
    }

    // MARK: Codable

    public enum CodingKeys: String, CodingKey {
        case items
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([BasicItem].self, forKey: .items)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
    }
}
public struct BasicDataSource: DataSource, Codable {
    public var sections: [Section]

    public init(sections: [Section] = [Section]()) {
        self.sections = sections
    }

    // MARK: Codable

    public enum CodingKeys: String, CodingKey {
        case sections
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sections = try container.decode([BasicSection].self, forKey: .sections)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sections, forKey: .sections)
    }
}

*/
