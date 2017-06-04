import Foundation

// MARK: - TableViewModel

public protocol TableViewModel {
    var title: String { get }
    var sections: [SectionViewModel] { get set }
}

public extension TableViewModel {
    public var title: String {
        return String()
    }
    public func item(at indexPath: IndexPath) -> ItemViewModel? {
        let item = sections[indexPath.section].items[indexPath.item]
        return item
    }
}

// MARK: - SectionViewModel

public protocol SectionViewModel {
    var header: String { get }
    var footer: String { get }
    var items: [ItemViewModel] { get set }
}

extension SectionViewModel {
    public var header: String {
        return String()
    }
    public var footer: String {
        return String()
    }
}

// MARK: - ItemViewModel

public protocol ItemViewModel {
    static var identifier: String { get }
    var model: ItemModel { get set }
    var table: TableViewModel? { get set }
}

extension ItemViewModel {
    public var identifier: String {
        return type(of: self).identifier
    }
}

// MARK: - ItemModel

public protocol ItemModel {
    var title: String { get }
    var detail: String { get }
    var image: String { get }
}

public extension ItemModel {
    public var title: String {
        return String()
    }
    public var detail: String {
        return String()
    }
    public var image: String {
        return String()
    }
}

public struct BasicItemModel: ItemModel {
    public let title: String
    public let detail: String
    public let image: String
    
    public init(title: String = String(), detail: String = String(), image: String = String()) {
        self.title = title
        self.detail = detail
        self.image = image
    }
}
