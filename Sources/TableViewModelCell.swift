import UIKit

// MARK: - TableViewModelCell

public protocol TableViewModelCell: class {
    static var nib: UINib? { get }
    
    var action: (_ sender: Any) -> Void { get set }
    
    func customize()
    func update(with item: Item)
    func reset()
}

public extension TableViewModelCell {
    static var nib: UINib? {
        let className = String(describing: type(of: self))
        guard let nibName = className.components(separatedBy: ".").first else {
            return nil
        }
        return UINib(nibName: nibName, bundle: nil)
    }
    var base: UITableViewCell? {
        return self as? UITableViewCell
    }
}

// MARK: - TableCell

public enum TableCell {
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

// MARK: - System Cells
    
open class TableCellBasic: UITableViewCell, TableViewModelCell {
    public var useAutomaticDisclosureIndicator = true
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customize()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        customize()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    public var action: (Any) -> Void = { _ in }
    open func customize() {}
    open func update(with item: Item) {
        if let data = item.data {
            textLabel?.text = data.title
            detailTextLabel?.text = data.detail
            if data.image != "", let image = UIImage(named: data.image) {
                imageView?.image = image
            }
        }
        configureAutomaticDisclosureIndicator(with: item)
    }
    open func reset() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
        imageView?.image = nil
    }
    
    open func configureAutomaticDisclosureIndicator(with item: Item) {
        if useAutomaticDisclosureIndicator, let table = item.data?.submodel as? Table, table.sections.count >= 0 {
            accessoryType = .disclosureIndicator
        }
    }
    @objc public func callAction(sender: Any) {
        action(sender)
    }
}

open class TableCellSubtitle: TableCellBasic {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
}

open class TableCellLeftDetail: TableCellBasic {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
}

open class TableCellRightDetail: TableCellBasic {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
}

// MARK: - Custom Cells
    
open class TableCellToggle: TableCellBasic {
    public let toggle = UISwitch()
    
    open override func customize() {
        selectionStyle = .none
        configureToggle()
    }
    private func configureToggle() {
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(callAction), for: .valueChanged)
    }
}

open class TableCellTextInput: TableCellBasic, UITextFieldDelegate {
    public let textField = UITextField()
    
    open override func customize() {
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
        
        textField.delegate = self
    }
    open override func update(with item: Item) {
        textField.placeholder = item.data?.title
    }
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        callAction(sender: textField)
        return false
    }
}

open class TableCellButton: TableCellBasic {
    public let button = UIButton(type: .system)
    
    open override func customize() {
        selectionStyle = .none
        configureButton()
    }
    private func configureButton() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        button.addTarget(self, action: #selector(callAction), for: .touchUpInside)
    }
    open override func update(with item: Item) {
        button.setTitle(item.data?.title, for: .normal)
    }
}
