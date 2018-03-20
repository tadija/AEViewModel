/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - NEW

protocol NewItem {}
protocol NewSection {
    var items: [[String : NewItem]] { get set }
}
protocol NewDataSource {
    var sections: [NewSection] { get set }
}

struct NewBasicItem: NewItem, Codable {
    let title: String?
    let detail: String?
    let image: String?
    var submodel: NewBasicDataSource?
}
struct NewBasicSection: NewSection, Codable {
    var items: [[String : NewItem]]

    enum CodingKeys: String, CodingKey {
        case items
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([[String : NewBasicItem]].self, forKey: .items)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
    }
}
struct NewBasicDataSource: NewDataSource, Codable {
    var sections: [NewSection]

    enum CodingKeys: String, CodingKey {
        case sections
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sections = try container.decode([NewBasicSection].self, forKey: .sections)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sections, forKey: .sections)
    }
}



//protocol NewItem {}
//protocol NewSection {
//    associatedtype ItemType: NewItem
//    var items: [[String : ItemType]] { get set }
//}
//protocol NewDataSource {
//    var sections: [Any] { get set }
//}
//
//extension NewDataSource {
//    var tmp: [NewSection]? {
//        return sections as? [NewSection]
//    }
//}
//
//struct NewBasicItem: NewItem, Codable {
//    let title: String?
//    let detail: String?
//}
//struct NewBasicSection: NewSection, Codable {
//    var items: [[String : NewBasicItem]]
//}
//struct NewBasicDataSource: NewDataSource, Codable {
//    var sections: [Any]
//
//    enum CodingKeys: String, CodingKey {
//        case sections
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        sections = try container.decode([NewBasicSection].self, forKey: .sections)
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(sections, forKey: .sections)
//    }
//}


//protocol NewItem {}
//protocol NewSection {
//    associatedtype ItemType: NewItem
//    var items: [[String : ItemType]] { get set }
//}
//protocol NewDataSource {
//    var sections: [NewSection] { get set }
//}
//
//struct CodableSection: NewSection, Codable {
//    var header: String?
//    var footer: String?
//    var items: [[String : CodableItem]]
//}
//
//struct CodableItem: NewItem, Codable {
//    let identifier: String
//    var data: [String : String]
//}

// MARK: - OLD

// MARK: - Protocols

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

// MARK: - Table

public typealias Table = DataSource
public typealias BasicTable = BasicDataSource

// MARK: - Collection

public typealias Collection = DataSource
public typealias BasicCollection = BasicDataSource
