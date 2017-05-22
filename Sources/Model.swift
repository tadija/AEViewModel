import Foundation
import Mappable

public struct Model: Mappable {
    public let identifier: String
    public var userInfo: [String : Any]?
    public var title: String?
    public var sections: [Section]?
    
    public init(_ identifier: String) {
        self.identifier = identifier
    }
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        userInfo = try? map.value(forKey: "user-info")
        title = try? map.value(forKey: "title")
        sections = try map.mappableArray(forKey: "sections")
    }
    
    public func item(at indexPath: IndexPath) -> Item? {
        let item = sections?[indexPath.section].items?[indexPath.item]
        return item
    }
}

public struct Section: Mappable {
    public let identifier: String
    public var userInfo: [String : Any]?
    public var header: String?
    public var footer: String?
    public var items: [Item]?
    
    public init(_ identifier: String) {
        self.identifier = identifier
    }
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        userInfo = try? map.value(forKey: "user-info")
        header = try? map.value(forKey: "header")
        footer = try? map.value(forKey: "footer")
        items = try map.mappableArray(forKey: "items")
    }
}

public struct Item: Mappable {
    public let identifier: String
    public var userInfo: [String : Any]?
    public var imageName: String?
    public var title: String?
    public var detail: String?
    public var model: Model?
    
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
        userInfo = try? map.value(forKey: "user-info")
        imageName = try? map.value(forKey: "image")
        title = try? map.value(forKey: "title")
        detail = try? map.value(forKey: "detail")
        model = try? map.mappable(forKey: "model")
    }
}
