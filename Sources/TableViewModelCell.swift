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
        case button
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
        private func configureTextField() {
            contentView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            let margins = contentView.layoutMarginsGuide
            textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            textField.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            textField.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            textField.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        }
        open override func updateUI(with item: ItemViewModel) {
            textField.placeholder = item.model.title
        }
    }
    
    open class Button: Basic {
        public let button = UIButton(type: .system)
        public var action: () -> Void = {}
        
        open override func customizeUI() {
            selectionStyle = .none
            configureButton()
            button.addTarget(self, action: #selector(callButtonAction), for: .touchUpInside)
        }
        private func configureButton() {
            contentView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
        @objc private func callButtonAction() {
            action()
        }
        open override func updateUI(with item: ItemViewModel) {
            button.setTitle(item.model.title, for: .normal)
        }
    }
    
}

public protocol ToggleCellDelegate: class {
    func didChangeValue(sender: Cell.Toggle)
}
