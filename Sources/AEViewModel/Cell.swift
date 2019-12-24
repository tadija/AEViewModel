/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2019 Marko Tadić
 *  Licensed under the MIT license
 */

import UIKit

public protocol CellDelegate: class {
    func callback(from cell: Cell, sender: Any)
}

public protocol Cell: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
    
    var delegate: CellDelegate? { get set }
    var userInfo: [AnyHashable: Any] { get set }

    func configure()
    func reset()
    func update(with item: Item)

    func callback(_ sender: Any)
}

public extension Cell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    func callback(_ sender: Any) {
        delegate?.callback(from: self, sender: sender)
    }
}
