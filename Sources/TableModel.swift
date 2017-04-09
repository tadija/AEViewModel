import Foundation
import Mappable

public struct Table: Mappable {
    let identifier: String
    let data: [String : Any]?
    
    let sections: [Section]
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        data = try? map.value(forKey: "data")
        sections = try map.objectsArray(forKey: "sections")
    }
}

public struct Section: Mappable {
    let identifier: String
    let data: [String : Any]?
    
    let items: [Item]
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        data = try? map.value(forKey: "data")
        items = try map.objectsArray(forKey: "items")
    }
}

public struct Item: Mappable {
    let identifier: String
    let data: [String : Any]
    
    var table: Table?
    
    var style: String?
    var image: String?
    var title: String?
    var detail: String?
    
    public init(map: [String : Any]) throws {
        identifier = try map.value(forKey: "id")
        table = try? map.object(forKey: "table")
        data = try map.value(forKey: "data")
        
        style = try map.value(forKey: "style")
        image = try? map.value(forKey: "image")
        title = try? map.value(forKey: "title")
        detail = try? map.value(forKey: "detail")
    }
}
