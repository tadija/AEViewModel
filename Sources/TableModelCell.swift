import UIKit

public protocol TableModelCell: class {
    func configure(with item: Item)
}

extension TableModelCell where Self: UITableViewCell {}

public enum TableModelCellStyle: String {
    case custom
    case `default`
    case subtitle
    case leftDetail
    case rightDetail
    
    var cellStyle: UITableViewCellStyle {
        switch self {
        case .`default`:
            return .default
        case .subtitle:
            return .subtitle
        case .leftDetail:
            return .value2
        case .rightDetail:
            return .value1
        default:
            return .default
        }
    }
    
    static func cellStyle(with item: Item) -> UITableViewCellStyle {
        guard
            let styleIdentifier = item.style,
            let itemStyle = TableModelCellStyle(rawValue: styleIdentifier)
        else {
            return .default
        }
        return itemStyle.cellStyle
    }
}
