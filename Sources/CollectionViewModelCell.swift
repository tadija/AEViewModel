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
    public weak var delegate: ViewModelCellDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        reset()
        setup()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        reset()
        setup()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    open func setup() {}
    open func update(with item: Item) {}
    open func reset() {}
    
    @objc public func performCallback(sender: Any) {
        delegate?.action(for: self, sender: sender)
    }
}
