import UIKit

public protocol TableCell: class {
    func configureUI()
    func updateUI(with item: Item)
}

open class Cell {
    private init() {}
}

extension Cell {
    
    public enum Style {
        case basic
        case subtitle
        case leftDetail
        case rightDetail
        case toggle
        case customClass(type: TableCell.Type)
        case customNib(nib: UINib?)
    }
    
    open class Basic: UITableViewCell, TableCell {
        
        // MARK: - Init
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            configureUI()
        }
        
        // MARK: - Lifecycle
        
        open override func awakeFromNib() {
            super.awakeFromNib()
            configureUI()
        }
        
        // MARK: - TableCell
        
        open func configureUI() {}
        
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
        
        open override func configureUI() {
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
