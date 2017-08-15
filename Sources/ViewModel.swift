import Foundation

// MARK: - Protocols

public protocol ViewModel {}

public protocol DataSourceModel: ViewModel {
    var sections: [Section] { get set }
}

public protocol Section: ViewModel {
    var items: [Item] { get set }
}

public protocol Item: ViewModel {
    var identifier: String { get }
    var data: ItemData? { get set }
}

public protocol ItemData {
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

public struct BasicDataSourceModel: DataSourceModel {
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

public typealias Table = DataSourceModel
public typealias BasicTable = BasicDataSourceModel

// MARK: - Collection

/// - Note: UICollectionView is also planned, but not yet implemented 😇
public typealias Collection = DataSourceModel
public typealias BasicCollection = BasicDataSourceModel
