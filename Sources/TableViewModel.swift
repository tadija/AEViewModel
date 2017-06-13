import Foundation

// MARK: - ViewModel

public protocol ViewModel {}

// MARK: - Table

public protocol Table: ViewModel {
    var title: String { get }
    var sections: [Section] { get set }
}

public extension Table {
    public var title: String {
        return String()
    }
    public func item(at indexPath: IndexPath) -> Item? {
        let item = sections[indexPath.section].items[indexPath.item]
        return item
    }
}

// MARK: - Section

public protocol Section: ViewModel {
    var header: String? { get set }
    var footer: String? { get set }
    var items: [Item] { get set }
}

// MARK: - Item

public protocol Item: ViewModel {
    var identifier: String { get }
    var data: ItemData? { get set }
    var table: Table? { get set }
}

// MARK: - Model

public protocol ItemData {
    var title: String? { get }
    var detail: String? { get }
    var image: String? { get }
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
