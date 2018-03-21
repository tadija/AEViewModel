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
}
public extension ViewModel {
    var title: String? { return nil }
    var detail: String? { return nil }
    var image: String? { return nil }
}
public protocol Item {
    var identifier: String { get }
    var model: ViewModel? { get set }
}
public protocol Section {
    var items: [Item] { get set }
}
public protocol DataSource {
    var sections: [Section] { get set }
}

public typealias Table = DataSource
public typealias Collection = DataSource

public typealias BasicTable = BasicDataSource
public typealias BasicCollection = BasicDataSource
