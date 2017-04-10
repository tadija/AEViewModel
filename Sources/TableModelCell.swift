import UIKit

public enum TableModelCellStyle: String {
    case `default`
    case subtitle
    case leftDetail
    case rightDetail
    case rightSwitch
    case customClass
    case customNib
}

public protocol TableModelCell: class {
    var style: TableModelCellStyle { get }
    func configure(with item: Item)
}

public extension TableModelCell where Self: UITableViewCell {
    
    public func configure(with item: Item) {
        imageView?.image = item.image
        textLabel?.text = item.title
        detailTextLabel?.text = item.detail
    }
    
}
