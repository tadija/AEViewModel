/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public protocol ViewModelCell: class {
    static var nib: UINib? { get }

    var callback: (_ sender: Any) -> Void { get set }

    func customize()
    func update(with item: Item)
    func reset()
}

public extension ViewModelCell {
    static var nib: UINib? {
        let className = String(describing: type(of: self))
        guard let nibName = className.components(separatedBy: ".").first else {
            return nil
        }
        return UINib(nibName: nibName, bundle: nil)
    }
}
