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
    
open class CollectionCellBasic: CollectionViewModelCell {
    public weak var delegate: ViewModelCellDelegate?
    open var userInfo = [AnyHashable : Any]()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    open func configure() {
        reset()
    }
    open func reset() {}
    open func update(with item: Item) {}
    
    @objc open func performCallback(_ sender: Any) {
        delegate?.action(for: self, sender: sender)
    }
}
