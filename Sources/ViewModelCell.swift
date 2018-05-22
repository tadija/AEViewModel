/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public protocol ViewModelCellDelegate: class {
    func callback(from cell: ViewModelCell, sender: Any)
}

public protocol ViewModelCell: class {
    var delegate: ViewModelCellDelegate? { get set }
    var userInfo: [AnyHashable : Any] { get set }

    func configure()
    func reset()
    func update(with item: Item)

    func callback(userInfo: [AnyHashable: Any]?, sender: Any)
}

public extension ViewModelCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
