/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

// MARK: - TableViewModelCell

public typealias TableViewModelCell = UITableViewCell & ViewModelCell

// MARK: - TableCell

public enum TableCell {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case button
    case toggleBasic
    case toggleSubtitle
    case textInput
    case customClass(type: TableViewModelCell.Type)
    case customNib(nib: UINib?)
}

// MARK: - System Cells
    
open class TableCellBasic: UITableViewCell, ViewModelCell {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        reset()
        customize()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        reset()
        customize()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    public var callback: (Any) -> Void = { _ in }

    open func reset() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
        imageView?.image = nil
    }
    open func customize() {}
    open func update(with item: Item) {
        textLabel?.text = item.viewModel.title
        detailTextLabel?.text = item.viewModel.detail
        if let imageName = item.viewModel.image, let image = UIImage(named: imageName) {
            imageView?.image = image
        }
    }

    @objc public func performCallback(sender: Any) {
        callback(sender)
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

public protocol TableCellToggle {
    var toggle: UISwitch { get }
}

public extension TableCellToggle where Self: TableCellBasic {
    func configureCell() {
        selectionStyle = .none
        configureToggle()
    }
    private func configureToggle() {
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(performCallback(sender:)), for: .valueChanged)
    }
}
    
open class TableCellToggleBasic: TableCellBasic, TableCellToggle {
    public let toggle = UISwitch()
    
    open override func customize() {
        configureCell()
    }
}

open class TableCellToggleSubtitle: TableCellSubtitle, TableCellToggle {
    public let toggle = UISwitch()
    
    open override func customize() {
        configureCell()
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
        textField.placeholder = item.viewModel.title
    }
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performCallback(sender: textField)
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
        
        button.addTarget(self, action: #selector(performCallback(sender:)), for: .touchUpInside)
    }
    open override func update(with item: Item) {
        button.setTitle(item.viewModel.title, for: .normal)
    }
}
