import UIKit

public protocol TableCell: class {
    func customizeUI()
    func updateUI(with item: Item)
}

public extension TableCell where Self: UITableViewCell {}

public struct Cell {
    private init() {}
}

extension Cell {
    
    public enum UI {
        case basic
        case subtitle
        case leftDetail
        case rightDetail
        case toggle
        case customClass(type: TableCell.Type)
        case customNib(nib: UINib?)
    }
    
    public struct ID {}
    
}

// MARK: - System Cells

extension Cell {
    
    open class Basic: UITableViewCell, TableCell {
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            customizeUI()
        }
        open override func awakeFromNib() {
            super.awakeFromNib()
            customizeUI()
        }
        
        open func customizeUI() {}
        open func updateUI(with item: Item) {
            imageView?.image = item.localImage
            textLabel?.text = item.title
            detailTextLabel?.text = item.detail
            configureAutomaticDisclosureIndicator(with: item)
        }
        open func configureAutomaticDisclosureIndicator(with item: Item) {
            if (item.model?.sections?.count ?? 0) > 0 {
                accessoryType = .disclosureIndicator
            }
        }
    }
    
    open class Subtitle: Basic {
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
    }
    
    open class LeftDetail: Basic {
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        }
    }
    
    open class RightDetail: Basic {
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        }
    }
    
}

// MARK: - Custom Cells

extension Cell {
    
    open class Toggle: Basic {
        public let toggle = UISwitch()
        public weak var delegate: ToggleCellDelegate?

        open override func customizeUI() {
            selectionStyle = .none
            accessoryView = toggle
            toggle.addTarget(self, action: #selector(callDelegate), for: .valueChanged)
        }
        @objc private func callDelegate() {
            delegate?.didChangeValue(sender: self)
        }
    }
    
}

public protocol ToggleCellDelegate: class {
    func didChangeValue(sender: Cell.Toggle)
}
