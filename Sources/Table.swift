import Foundation
import Mappable

public protocol Model: Mappable {
    var identifier: String { get }
    var userInfo: [String : Any]? { get set }
    init(_ identifier: String)
}

public struct Table: Model {
    public let identifier: String
    public var sections: [Section]?
    public var userInfo: [String : Any]?
    
    public var title: String?
    
    public init(_ identifier: String) {
        self.identifier = identifier
    }
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        sections = try map.mappableArray(forKey: "sections")
        userInfo = try? map.value(forKey: "user-info")
        title = try? map.value(forKey: "title")
    }
    
    public func item(at indexPath: IndexPath) -> Item? {
        let item = sections?[indexPath.section].items?[indexPath.item]
        return item
    }
}

public struct Section: Model {
    public let identifier: String
    public var items: [Item]?
    public var userInfo: [String : Any]?
    
    public var header: String?
    public var footer: String?
    
    public init(_ identifier: String) {
        self.identifier = identifier
    }
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        items = try map.mappableArray(forKey: "items")
        userInfo = try? map.value(forKey: "user-info")
        header = try? map.value(forKey: "header")
        footer = try? map.value(forKey: "footer")
    }
}

public struct Item: Model {
    public let identifier: String
    public var table: Table?
    public var userInfo: [String : Any]?
    
    public var imageName: String?
    public var title: String?
    public var detail: String?
    
    public var image: UIImage? {
        guard let imageName = imageName else {
            return nil
        }
        return UIImage(named: imageName)
    }
    
    public init(_ identifier: String) {
        self.identifier = identifier
    }
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        table = try? map.mappable(forKey: "table")
        userInfo = try? map.value(forKey: "user-info")
        
        imageName = try? map.value(forKey: "image")
        title = try? map.value(forKey: "title")
        detail = try? map.value(forKey: "detail")
    }
}
