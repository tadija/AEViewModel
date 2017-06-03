import UIKit

// MARK: - TableViewModelCell

public protocol TableViewModelCell: class {
    func customizeUI()
    func updateUI(with item: ItemViewModel)
}

public extension TableViewModelCell where Self: UITableViewCell {}

// MARK: - Cell

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
        case textInput
        case customClass(type: TableViewModelCell.Type)
        case customNib(nib: UINib?)
    }
}

// MARK: - System Cells

extension Cell {
    
    open class Basic: UITableViewCell, TableViewModelCell {
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
        open func updateUI(with item: ItemViewModel) {
            textLabel?.text = item.model.title
            detailTextLabel?.text = item.model.detail
            imageView?.image = UIImage(named: item.model.image)
            configureAutomaticDisclosureIndicator(with: item)
        }
        open func configureAutomaticDisclosureIndicator(with item: ItemViewModel) {
            if (item.table?.sections.count ?? 0) > 0 {
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
    
    open class TextInput: Basic {
        public let textField = UITextField()
        public weak var delegate: UITextFieldDelegate? {
            didSet {
                textField.delegate = delegate
            }
        }
        
        open override func customizeUI() {
            selectionStyle = .none
            configureTextField()
        }
        open override func updateUI(with item: ItemViewModel) {
            textField.placeholder = item.model.title
        }
        private func configureTextField() {
            contentView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            let margins = contentView.layoutMarginsGuide
            textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            textField.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            textField.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            textField.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        }
    }
    
}

public protocol ToggleCellDelegate: class {
    func didChangeValue(sender: Cell.Toggle)
}
