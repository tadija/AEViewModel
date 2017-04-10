import UIKit

public protocol TableModelCell: class {
    func configure(with item: Item)
}

extension TableModelCell where Self: UITableViewCell {
    public func configure(with item: Item) {
        imageView?.image = item.image
        textLabel?.text = item.title
        detailTextLabel?.text = item.detail
    }
}
