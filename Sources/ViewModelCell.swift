/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public protocol ViewModelCell: class {
    var callback: (_ sender: Any) -> Void { get set }
    func setup()
    func update(with item: Item)
    func reset()
}

public extension ViewModelCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
