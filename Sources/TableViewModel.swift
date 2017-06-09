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
    static var identifier: String { get }
    var model: Model? { get set }
    var table: Table? { get set }
}

extension Item {
    public var identifier: String {
        return type(of: self).identifier
    }
}

// MARK: - Model

public protocol Model {
    var title: String { get }
    var detail: String { get }
    var image: String { get }
}

public extension Model {
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

public struct BasicModel: Model {
    public let title: String
    public let detail: String
    public let image: String
    
    public init(title: String = String(), detail: String = String(), image: String = String()) {
        self.title = title
        self.detail = detail
        self.image = image
    }
}
