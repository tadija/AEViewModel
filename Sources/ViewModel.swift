/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

public protocol ViewModel {
    var title: String? { get }
    var detail: String? { get }
    var image: String? { get }
    var child: DataSource? { get }
}

public protocol Item {
    var identifier: String { get }
    var viewModel: ViewModel { get }
}

public protocol Section {
    var header: String? { get }
    var footer: String? { get }
    var items: [Item] { get set }
}

public protocol DataSource {
    var title: String? { get }
    var sections: [Section] { get set }
}

// MARK: - Helpers

public extension ViewModel {
    var title: String? { return nil }
    var detail: String? { return nil }
    var image: String? { return nil }
    var child: DataSource? { return nil }
}

public extension Section {
    var header: String? { return nil }
    var footer: String? { return nil }
}

public extension DataSource {
    var title: String? { return nil }

    func item(at indexPath: IndexPath) -> Item {
        return sections[indexPath.section].items[indexPath.item]
    }
    func identifier(at indexPath: IndexPath) -> String {
        return item(at: indexPath).identifier
    }
    func viewModel(at indexPath: IndexPath) -> ViewModel {
        return item(at: indexPath).viewModel
    }

    var uniqueIdentifiers: Set<String> {
        var ids: Set<String> = Set<String>()
        sections.forEach { section in
            let allSectionIdentifiers: [String] = section.items.flatMap({ $0.identifier })
            ids.formUnion(allSectionIdentifiers)
        }
        return ids
    }
}
