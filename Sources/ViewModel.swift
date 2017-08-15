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
    var child: ViewModel? { get set }
}

public protocol ItemData {
    var title: String? { get }
    var detail: String? { get }
    var image: String? { get }
}

public extension ItemData {
    var title: String? { return nil }
    var detail: String? { return nil }
    var image: String? { return nil }
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
    public var child: ViewModel?
    
    public init(identifier: String, data: ItemData? = nil, child: ViewModel? = nil) {
        self.identifier = identifier
        self.data = data
        self.child = child
    }
    
    public init(identifier: String,
                title: String? = nil, detail: String? = nil, image: String? = nil,
                child: ViewModel? = nil) {
        self.identifier = identifier
        self.data = BasicItemData(title: title, detail: detail, image: image)
        self.child = child
    }
}

public struct BasicItemData: ItemData {
    public let title: String?
    public let detail: String?
    public let image: String?
    
    public init(title: String? = nil, detail: String? = nil, image: String? = nil) {
        self.title = title
        self.detail = detail
        self.image = image
    }
}

// MARK: - Table

public typealias Table = DataSourceModel
public typealias BasicTable = BasicDataSourceModel

// MARK: - Collection

/// - Note: UICollectionView is also planned, but not yet implemented 😇
public typealias Collection = DataSourceModel
public typealias BasicCollection = BasicDataSourceModel
