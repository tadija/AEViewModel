import Foundation
import Mappable

public struct Model: Mappable {
    public let identifier: String
    public var userInfo: [String : Any]?
    public var title: String?
    public var sections: [Section]?
    
    public init(_ identifier: String, _ block: ((inout Model) -> Void)? = nil) {
        self.identifier = identifier
        if let block = block {
            block(&self)   
        }
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
    
    public init(_ identifier: String, _ block: ((inout Section) -> Void)? = nil) {
        self.identifier = identifier
        if let block = block {
            block(&self)
        }
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
    public var image: String?
    public var title: String?
    public var detail: String?
    public var model: Model?
    
    public var localImage: UIImage? {
        guard let image = image else {
            return nil
        }
        return UIImage(named: image)
    }
    
    public init(_ identifier: String, _ block: ((inout Item) -> Void)? = nil) {
        self.identifier = identifier
        if let block = block {
            block(&self)
        }
    }
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        userInfo = try? map.value(forKey: "user-info")
        image = try? map.value(forKey: "image")
        title = try? map.value(forKey: "title")
        detail = try? map.value(forKey: "detail")
        model = try? map.mappable(forKey: "model")
    }
}
