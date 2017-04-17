import Foundation
import Mappable

public struct TableModel: Mappable {
    public let identifier: String
    public let sections: [Section]
    public let data: [String : Any]?
    
    public var title: String?
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        sections = try map.objectsArray(forKey: "sections")
        data = try? map.value(forKey: "data")
        title = try? map.value(forKey: "title")
    }
    
    public func item(at indexPath: IndexPath) -> Item {
        let item = sections[indexPath.section].items[indexPath.item]
        return item
    }
}

public struct Section: Mappable {
    public let identifier: String
    public let items: [Item]
    public let data: [String : Any]?
    
    public var headerTitle: String?
    public var footerTitle: String?
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        items = try map.objectsArray(forKey: "items")
        data = try? map.value(forKey: "data")
        headerTitle = try? map.value(forKey: "header-title")
        footerTitle = try? map.value(forKey: "footer-title")
    }
}

public struct Item: Mappable {
    public let identifier: String
    public var submodel: TableModel?
    public let data: [String : Any]?
    
    public var imageName: String?
    public var title: String?
    public var detail: String?
    
    public var image: UIImage? {
        guard let imageName = imageName else {
            return nil
        }
        return UIImage(named: imageName)
    }
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        submodel = try? map.object(forKey: "table")
        data = try? map.value(forKey: "data")
        
        imageName = try? map.value(forKey: "image")
        title = try? map.value(forKey: "title")
        detail = try? map.value(forKey: "detail")
    }
}
