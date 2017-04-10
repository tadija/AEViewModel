import Foundation
import Mappable

public struct TableModel: Mappable {
    let identifier: String
    let sections: [Section]
    let data: [String : Any]?
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        sections = try map.objectsArray(forKey: "sections")
        data = try? map.value(forKey: "data")
    }
}

public struct Section: Mappable {
    let identifier: String
    let items: [Item]
    let data: [String : Any]?
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        items = try map.objectsArray(forKey: "items")
        data = try? map.value(forKey: "data")
    }
}

public struct Item: Mappable {
    let identifier: String
    var submodel: TableModel?
    let data: [String : Any]
    
    var imageName: String?
    var title: String?
    var detail: String?
    
    var image: UIImage? {
        guard let imageName = imageName else {
            return nil
        }
        return UIImage(named: imageName)
    }
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        submodel = try? map.object(forKey: "table")
        data = try map.value(forKey: "data")
        
        imageName = try? map.value(forKey: "image")
        title = try? map.value(forKey: "title")
        detail = try? map.value(forKey: "detail")
    }
}
