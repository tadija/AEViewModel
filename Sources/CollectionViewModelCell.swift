/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

// MARK: - CollectionViewModelCell

public typealias CollectionViewModelCell = UICollectionViewCell & ViewModelCell

// MARK: - CollectionCell

public enum CollectionCell {
    case empty
    case customClass(type: CollectionViewModelCell.Type)
    case customNib(nib: UINib?)
}

// MARK: - Cells
    
open class CollectionCellEmpty: UICollectionViewCell, ViewModelCell {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
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
