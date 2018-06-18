/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public typealias CollectionCell = UICollectionViewCell & Cell

public enum CollectionCellType {
    case basic
    case spinner
    case customClass(CollectionCell.Type)
    case customNib(CollectionCell.Type)
}

// MARK: - Base Cells
    
open class CollectionCellBasic: CollectionCell {
    public weak var delegate: CellDelegate?

    open var userInfo: [AnyHashable: Any] {
        get { return _userInfo }
        set { _userInfo.merge(newValue) { (_, new) in new } }
    }
    private var _userInfo = [AnyHashable: Any]()

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

    @objc open func callback(_ sender: Any) {
        delegate?.callback(from: self, sender: sender)
    }
}

open class CollectionCellStack: CollectionCellBasic {
    public let stack = UIStackView()

    open override func configure() {
        super.configure()

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        let margins = contentView.layoutMarginsGuide
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
}

// MARK: - Custom Cells

open class CollectionCellSpinner: CollectionCellBasic {
    public let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    open override func configure() {
        super.configure()
        
        contentView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false

        let margins = contentView.layoutMarginsGuide
        spinner.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }

    open override func reset() {
        super.reset()
        spinner.startAnimating()
    }
}
