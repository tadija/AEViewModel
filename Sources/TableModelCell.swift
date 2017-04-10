import UIKit

public enum TableModelCellStyle {
    case `default`
    case subtitle
    case leftDetail
    case rightDetail
    case rightSwitch
    case customClass(type: TableModelCell.Type)
    case customNib(nib: UINib?)
}

public protocol TableModelCell: class {
    func configure(with item: Item)
}

public extension TableModelCell where Self: UITableViewCell {
    
    public func configure(with item: Item) {
        imageView?.image = item.image
        textLabel?.text = item.title
        detailTextLabel?.text = item.detail
    }
    
}
