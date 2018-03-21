/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - NEW

public protocol Item {}
public protocol Section {
    var items: [[String : Item]] { get set }
}
public protocol DataSource {
    var sections: [Section] { get set }
}

public struct BasicItem: Item, Codable {
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
public struct BasicSection: Section, Codable {
    public var items: [[String : Item]]

    public init(items: [[String : Item]] = [[String : Item]]()) {
        self.items = items
    }

    // MARK: Codable

    public enum CodingKeys: String, CodingKey {
        case items
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([[String : BasicItem]].self, forKey: .items)
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

public typealias Table = DataSource
public typealias Collection = DataSource

public typealias BasicTable = BasicDataSource
public typealias BasicCollection = BasicDataSource

// MARK: - OLD

// MARK: - Protocols

/*
public protocol ViewModel {}

public protocol DataSource: ViewModel {
    var sections: [Section] { get set }
}

public protocol Section: ViewModel {
    var items: [Item] { get set }
}

public protocol Item: ViewModel {
    var identifier: String { get }
    var data: ItemData? { get set }
}

public protocol ItemData: ViewModel {
    var title: String? { get }
    var detail: String? { get }
    var image: String? { get }
    var submodel: ViewModel? { get }
}

public extension ItemData {
    var title: String? { return nil }
    var detail: String? { return nil }
    var image: String? { return nil }
    var submodel: ViewModel? { return nil }
}

// MARK: - Basic Structs

public struct BasicDataSource: DataSource {
    public var sections: [Section]
    
    public init(sections: [Section] = [Section]()) {
        self.sections = sections
    }
}

public struct BasicSection: Section {
    public var items: [Item]
    
    public init(items: [Item] = [Item]()) {
        self.items = items
    }
}

public struct BasicItem: Item {
    public let identifier: String
    public var data: ItemData?
    
    public init(identifier: String, data: ItemData? = nil) {
        self.identifier = identifier
        self.data = data
    }
    
    public init(identifier: String,
                title: String? = nil, detail: String? = nil, image: String? = nil, submodel: ViewModel? = nil) {
        self.identifier = identifier
        self.data = BasicItemData(title: title, detail: detail, image: image, submodel: submodel)
    }
}

public struct BasicItemData: ItemData {
    public let title: String?
    public let detail: String?
    public let image: String?
    public var submodel: ViewModel?
    
    public init(title: String? = nil, detail: String? = nil, image: String? = nil, submodel: ViewModel? = nil) {
        self.title = title
        self.detail = detail
        self.image = image
        self.submodel = submodel
    }
}
*/
