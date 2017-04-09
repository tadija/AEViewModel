import Foundation

public struct Table: Convertible {
    let identifier: String
    let data: [String : Any]?
    
    let sections: [Section]
    
    public init(dictionary: [String : Any]) throws {
        identifier = try dictionary.value(forKey: "id")
        data = try? dictionary.value(forKey: "data")
        sections = try dictionary.objectsArray(forKey: "sections")
    }
}

public struct Section: Convertible {
    let identifier: String
    let data: [String : Any]?
    
    let items: [Item]
    
    public init(dictionary: [String : Any]) throws {
        identifier = try dictionary.value(forKey: "id")
        data = try? dictionary.value(forKey: "data")
        items = try dictionary.objectsArray(forKey: "items")
    }
}

public struct Item: Convertible {
    let identifier: String
    let data: [String : Any]
    
    var table: Table?
    
    var style: String?
    var image: String?
    var title: String?
    var detail: String?
    
    public init(dictionary: [String : Any]) throws {
        identifier = try dictionary.value(forKey: "id")
        table = try? dictionary.object(forKey: "table")
        data = try dictionary.value(forKey: "data")
        
        style = try dictionary.value(forKey: "style")
        image = try? dictionary.value(forKey: "image")
        title = try? dictionary.value(forKey: "title")
        detail = try? dictionary.value(forKey: "detail")
    }
}
