import UIKit

public protocol TableCell: class {
    func customizeUI()
    func updateUI(with item: Item)
}

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

extension Cell {
    
    open class Basic: UITableViewCell, TableCell {
        
        // MARK: - Init
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            customizeUI()
        }
        
        // MARK: - Lifecycle
        
        open override func awakeFromNib() {
            super.awakeFromNib()
            customizeUI()
        }
        
        // MARK: - TableCell
        
        open func customizeUI() {}
        
        open func updateUI(with item: Item) {
            imageView?.image = item.image
            textLabel?.text = item.title
            detailTextLabel?.text = item.detail
            
            if (item.table?.sections?.count ?? 0) > 0 {
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
    
    open class Toggle: Basic {
        
        // MARK: - Outlets
        
        public let toggle = UISwitch()
        
        // MARK: - Properties
        
        public weak var delegate: ToggleCellDelegate?
        
        // MARK: - TableCell
        
        open override func customizeUI() {
            selectionStyle = .none
            accessoryView = toggle
            
            toggle.addTarget(self, action: #selector(callDelegate), for: .valueChanged)
        }
        
        // MARK: - Helpers
        
        @objc private func callDelegate() {
            delegate?.didChangeValue(sender: self)
        }
        
    }
    
}

public protocol ToggleCellDelegate: class {
    func didChangeValue(sender: Cell.Toggle)
}
