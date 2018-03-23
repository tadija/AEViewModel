/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public typealias CollectionViewModelCell = UICollectionViewCell & ViewModelCell

public enum CollectionCellType {
    case basic
    case customClass(CollectionViewModelCell.Type)
    case customNib(CollectionViewModelCell.Type)
}

// MARK: - Cells
    
open class CollectionCellBasic: UICollectionViewCell, ViewModelCell {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        reset()
        customize()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        reset()
        customize()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    public var callback: (Any) -> Void = { _ in }
    
    open func customize() {}
    open func update(with item: Item) {}
    open func reset() {}
    
    @objc public func performCallback(sender: Any) {
        callback(sender)
    }
}
