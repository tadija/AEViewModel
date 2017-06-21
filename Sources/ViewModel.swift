import Foundation

// MARK: - ViewModel

public protocol ViewModel {}

// MARK: - DataSourceViewModel

public protocol DataSourceModel: ViewModel {
    var title: String { get set }
    var sections: [Section] { get set }
}

public extension DataSourceModel {
    public func item(at indexPath: IndexPath) -> Item? {
        let item = sections[indexPath.section].items[indexPath.item]
        return item
    }
}

public struct BasicDataSourceModel: DataSourceModel {
    public var title: String
    public var sections: [Section]
    
    public init(title: String = String(), sections: [Section] = [Section]()) {
        self.title = title
        self.sections = sections
    }
}

// MARK: - Section

public protocol Section: ViewModel {
    var header: String? { get set }
    var footer: String? { get set }
    var items: [Item] { get set }
}

public struct BasicSection: Section {
    public var items: [Item]
    public var header: String?
    public var footer: String?
    
    public init(items: [Item] = [Item](), header: String? = nil, footer: String? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
    }
}

// MARK: - Item

public protocol Item: ViewModel {
    var identifier: String { get }
    var data: ItemData? { get set }
    var child: ViewModel? { get set }
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

// MARK: - ItemData

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
