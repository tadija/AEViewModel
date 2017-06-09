import UIKit

// MARK: - TableViewModelCell

public protocol TableViewModelCell: class {
    func customizeUI()
    func updateUI(with item: Item)
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
        public var action: () -> Void = {}
        
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
            if let model = item.model {
                textLabel?.text = model.title
                detailTextLabel?.text = model.detail
                imageView?.image = UIImage(named: model.image)
            }
            configureAutomaticDisclosureIndicator(with: item)
        }
        open func configureAutomaticDisclosureIndicator(with item: Item) {
            if (item.table?.sections.count ?? 0) > 0 {
                accessoryType = .disclosureIndicator
            }
        }
        
        @objc fileprivate func callAction() {
            action()
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

        open override func customizeUI() {
            selectionStyle = .none
            accessoryView = toggle
            toggle.addTarget(self, action: #selector(callAction), for: .valueChanged)
        }
    }
    
    open class TextInput: Basic {
        public let textField = UITextField()
        
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
        open override func updateUI(with item: Item) {
            textField.placeholder = item.model?.title
        }
    }
    
    open class Button: Basic {
        public let button = UIButton(type: .system)
        
        open override func customizeUI() {
            selectionStyle = .none
            configureButton()
            button.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        }
        private func configureButton() {
            contentView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
        open override func updateUI(with item: Item) {
            button.setTitle(item.model?.title, for: .normal)
        }
    }
    
}
