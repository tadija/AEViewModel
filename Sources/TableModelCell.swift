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

extension TableModelCell where Self: UITableViewCell {}
