/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public protocol CellDelegate: class {
    func callback(from cell: Cell, sender: Any)
}

public protocol Cell: class {
    var delegate: CellDelegate? { get set }
    var userInfo: [AnyHashable : Any] { get set }

    func configure()
    func reset()
    func update(with item: Item)

    func callback(userInfo: [AnyHashable: Any]?, sender: Any)
}

public extension Cell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
