import Foundation

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

public protocol ItemViewModel {
    var identifier: String { get }
    var model: ItemModel { get set }
    var table: TableViewModel? { get set }
}

public protocol ItemModel {
    var image: String { get }
    var title: String { get }
    var detail: String { get }
}

public extension ItemModel {
    public var image: String {
        return String()
    }
    public var title: String {
        return String()
    }
    public var detail: String {
        return String()
    }
}
