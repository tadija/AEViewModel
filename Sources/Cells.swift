import UIKit

public protocol TableCell: class {
    func configure(with item: Item)
}

extension TableCell where Self: UITableViewCell {}

public enum ItemStyle: String {
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
            let itemStyle = ItemStyle(rawValue: styleIdentifier)
        else {
            return .default
        }
        return itemStyle.cellStyle
    }
}

public class SubtitleCell: UITableViewCell {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
