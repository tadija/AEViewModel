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
    case textField
    case slider
    case sliderWithLabels
    case toggle
    case toggleWithSubtitle
    case button
    case customClass(TableViewModelCell.Type)
    case customNib(TableViewModelCell.Type)
}

public enum TableCellUserInfo: String {
    case toggleIsOn
    case sliderValue
}

// MARK: - System Cells
    
open class TableCellBasic: TableViewModelCell {
    public weak var delegate: ViewModelCellDelegate?
    open var userInfo = [AnyHashable : Any]()

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }

    open func configure() {
        reset()
    }
    open func reset() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
        imageView?.image = nil
    }
    open func update(with item: Item) {
        if let viewModel = item.viewModel as? BasicViewModel {
            textLabel?.text = viewModel.title
            detailTextLabel?.text = viewModel.detail
            if let imageName = viewModel.image, let image = UIImage(named: imageName) {
                imageView?.image = image
            }
        }
    }

    open func callback(userInfo: [AnyHashable: Any]? = nil, sender: Any) {
        if let userInfo = userInfo {
            self.userInfo = userInfo
        }
        delegate?.callback(from: self, sender: sender)
    }

    public func enforceMinimumHeight(for view: UIView, height: CGFloat = 44) {
        let height = view.heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        height.priority = .defaultHigh
        height.isActive = true
    }

    @objc public func performCallback(_ sender: Any) {
        callback(sender: sender)
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

open class TableCellStack: TableCellBasic {
    public let stack = UIStackView()

    open override func configure() {
        super.configure()

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        let margins = contentView.layoutMarginsGuide
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
}
    
open class TableCellToggle: TableCellBasic {
    public struct ViewModel: AEViewModel.ViewModel {
        public let title: String
        public let isOn: Bool

        public init(title: String, isOn: Bool) {
            self.title = title
            self.isOn = isOn
        }
    }

    public let toggle = UISwitch()
    
    open override func configure() {
        super.configure()

        selectionStyle = .none
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(performCallback(_:)), for: .valueChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? ViewModel {
            textLabel?.text = viewModel.title
            toggle.isOn = viewModel.isOn
        } else {
            super.update(with: item)
        }
    }
    open override func callback(userInfo: [AnyHashable : Any]?, sender: Any) {
        super.callback(userInfo: [TableCellUserInfo.toggleIsOn: toggle.isOn], sender: sender)
    }
}

open class TableCellToggleWithSubtitle: TableCellSubtitle {
    public struct ViewModel: AEViewModel.ViewModel {
        public let title: String
        public let subtitle: String
        public let isOn: Bool

        public init(title: String, subtitle: String, isOn: Bool) {
            self.title = title
            self.subtitle = subtitle
            self.isOn = isOn
        }
    }

    public let toggle = UISwitch()
    
    open override func configure() {
        super.configure()

        selectionStyle = .none
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(performCallback(_:)), for: .valueChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? ViewModel {
            textLabel?.text = viewModel.title
            detailTextLabel?.text = viewModel.subtitle
            toggle.isOn = viewModel.isOn
        } else {
            super.update(with: item)
        }
    }
    open override func callback(userInfo: [AnyHashable : Any]?, sender: Any) {
        super.callback(userInfo: [TableCellUserInfo.toggleIsOn: toggle.isOn], sender: sender)
    }
}

open class TableCellTextField: TableCellBasic {
    public let textField = UITextField()
    
    open override func configure() {
        super.configure()

        selectionStyle = .none

        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        let margins = contentView.layoutMarginsGuide
        textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        enforceMinimumHeight(for: textField)

        textField.addTarget(self, action: #selector(performCallback(_:)), for: .editingChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? BasicViewModel {
            textField.placeholder = viewModel.title
        }
    }
}

open class TableCellButton: TableCellBasic {
    public let button = UIButton(type: .system)
    
    open override func configure() {
        super.configure()

        selectionStyle = .none

        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        enforceMinimumHeight(for: button)

        button.addTarget(self, action: #selector(performCallback(_:)), for: .touchUpInside)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? BasicViewModel {
            button.setTitle(viewModel.title, for: .normal)
        }
    }
}

open class TableCellSlider: TableCellBasic {
    public struct ViewModel: AEViewModel.ViewModel {
        public let value: Float

        public init(value: Float) {
            self.value = value
        }
    }

    public let slider = UISlider()

    open override func configure() {
        super.configure()

        selectionStyle = .none

        contentView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false

        let margins = contentView.layoutMarginsGuide
        slider.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        slider.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        slider.addTarget(self, action: #selector(performCallback(_:)), for: .valueChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? ViewModel {
            slider.value = viewModel.value
        }
    }
    open override func callback(userInfo: [AnyHashable : Any]?, sender: Any) {
        super.callback(userInfo: [TableCellUserInfo.sliderValue: slider.value], sender: sender)
    }
}

open class TableCellSliderWithLabels: TableCellStack {
    public struct ViewModel: AEViewModel.ViewModel {
        public let leftText: String?
        public let centerText: String?
        public let rightText: String?
        public let value: Float
        
        public init(leftText: String? = nil, centerText: String? = nil, rightText: String? = nil, value: Float) {
            self.leftText = leftText
            self.centerText = centerText
            self.rightText = rightText
            self.value = value
        }
    }

    public let labelStack = UIStackView()
    public let leftLabel = UILabel()
    public let centerLabel = UILabel()
    public let rightLabel = UILabel()
    public let slider = UISlider()

    open override func configure() {
        super.configure()

        selectionStyle = .none

        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 4

        labelStack.axis = .horizontal
        labelStack.alignment = .center
        labelStack.distribution = .equalSpacing
        labelStack.addArrangedSubview(leftLabel)
        labelStack.addArrangedSubview(centerLabel)
        labelStack.addArrangedSubview(rightLabel)

        stack.addArrangedSubview(labelStack)
        stack.addArrangedSubview(slider)

        slider.addTarget(self, action: #selector(performCallback(_:)), for: .valueChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? ViewModel {
            leftLabel.text = viewModel.leftText
            centerLabel.text = viewModel.centerText
            rightLabel.text = viewModel.rightText
            slider.value = viewModel.value
        }
    }
    open override func callback(userInfo: [AnyHashable : Any]?, sender: Any) {
        super.callback(userInfo: [TableCellUserInfo.sliderValue: slider.value], sender: sender)
    }
}
