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

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    open func setup() {
        reset()
    }
    open func update(with item: Item) {}
    open func reset() {}
    
    @objc public func performCallback(_ sender: Any) {
        delegate?.action(for: self, sender: sender)
    }
}
