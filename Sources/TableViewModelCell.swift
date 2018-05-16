/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public typealias TableViewModelCell = UITableViewCell & ViewModelCell

public enum TableCellType {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case button
    case toggleBasic
    case toggleSubtitle
    case textInput
    case customClass(TableViewModelCell.Type)
    case customNib(TableViewModelCell.Type)
}

// MARK: - System Cells
    
open class TableCellBasic: UITableViewCell, ViewModelCell {
    public weak var delegate: ViewModelCellDelegate?

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }

    open func setup() {
        reset()
    }
    open func reset() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
        imageView?.image = nil
    }
    open func update(with item: Item) {
        textLabel?.text = item.model.title
        detailTextLabel?.text = item.model.detail
        if let imageName = item.model.image, let image = UIImage(named: imageName) {
            imageView?.image = image
        }
    }

    @objc public func performCallback(_ sender: Any) {
        delegate?.action(for: self, sender: sender)
    }
}

open class TableCellSubtitle: TableCellBasic {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

open class TableCellLeftDetail: TableCellBasic {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

open class TableCellRightDetail: TableCellBasic {
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Custom Cells

public protocol TableCellToggle {
    var toggle: UISwitch { get }
}

public extension TableCellToggle where Self: TableCellBasic {
    func setupCellWithToggle() {
        selectionStyle = .none
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(performCallback(_:)), for: .valueChanged)
    }
}
    
open class TableCellToggleBasic: TableCellBasic, TableCellToggle {
    public let toggle = UISwitch()
    
    open override func setup() {
        super.setup()
        setupCellWithToggle()
    }
}

open class TableCellToggleSubtitle: TableCellSubtitle, TableCellToggle {
    public let toggle = UISwitch()
    
    open override func setup() {
        super.setup()
        setupCellWithToggle()
    }
}

open class TableCellTextInput: TableCellBasic, UITextFieldDelegate {
    public let textField = UITextField()
    
    open override func setup() {
        super.setup()
        setupCellWithTextField()
    }
    private func setupCellWithTextField() {
        selectionStyle = .none

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
        textField.placeholder = item.model.title
    }
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performCallback(textField)
        return false
    }
}

open class TableCellButton: TableCellBasic {
    public let button = UIButton(type: .system)
    
    open override func setup() {
        super.setup()
        setupCellWithButton()
    }
    private func setupCellWithButton() {
        selectionStyle = .none
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        let height = button.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        height.priority = .defaultHigh
        height.isActive = true
        
        button.addTarget(self, action: #selector(performCallback(_:)), for: .touchUpInside)
    }
    open override func update(with item: Item) {
        button.setTitle(item.model.title, for: .normal)
    }
}
