/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - Protocols

public protocol ViewModel {
    var title: String? { get }
    var detail: String? { get }
    var image: String? { get }
}

public protocol Item {
    var viewModel: ViewModel { get }
    var cellIdentifier: String { get }
}

public protocol Section {
    var items: [Item] { get set }
}

public protocol DataSource {
    var sections: [Section] { get set }
}

// MARK: - Helpers

public extension ViewModel {
    var title: String? { return nil }
    var detail: String? { return nil }
    var image: String? { return nil }
}

public extension DataSource {
    func item(at indexPath: IndexPath) -> Item {
        return sections[indexPath.section].items[indexPath.item]
    }
    func viewModel(at indexPath: IndexPath) -> ViewModel {
        return item(at: indexPath).viewModel
    }
    func cellIdentifier(at indexPath: IndexPath) -> String {
        return item(at: indexPath).cellIdentifier
    }
    var uniqueCellIdentifiers: Set<String> {
        var ids: Set<String> = Set<String>()
        sections.forEach { section in
            let allSectionIdentifiers: [String] = section.items.flatMap({ $0.cellIdentifier })
            ids.formUnion(allSectionIdentifiers)
        }
        return ids
    }
}
