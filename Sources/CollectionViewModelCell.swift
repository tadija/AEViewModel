import UIKit

// MARK: - CollectionViewModelCell

public protocol CollectionViewModelCell: class {
    static var nib: UINib? { get }
    
    var action: (_ sender: Any) -> Void { get set }
    
    func customize()
    func update(with item: Item)
    func reset()
}

public extension CollectionViewModelCell {
    static var nib: UINib? {
        let className = String(describing: type(of: self))
        guard let nibName = className.components(separatedBy: ".").first else {
            return nil
        }
        return UINib(nibName: nibName, bundle: nil)
    }
    var base: UICollectionViewCell? {
        return self as? UICollectionViewCell
    }
}

// MARK: - CollectionCell

public enum CollectionCell {
    case empty
    case customClass(type: CollectionViewModelCell.Type)
    case customNib(nib: UINib?)
}

// MARK: - Cells
    
open class CollectionCellEmpty: UICollectionViewCell, CollectionViewModelCell {
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
    
    public var action: (Any) -> Void = { _ in }
    
    open func customize() {}
    open func update(with item: Item) {}
    open func reset() {}
    
    @objc public func callAction(sender: Any) {
        action(sender)
    }
}
