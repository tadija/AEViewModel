/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public typealias TableCell = UITableViewCell & Cell

public enum TableCellType {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case toggle
    case toggleWithSubtitle
    case slider
    case sliderWithLabels
    case textField
    case textView
    case button
    case spinner
    case customClass(TableCell.Type)
    case customNib(TableCell.Type)
}

public enum TableCellUserInfo: String {
    case sliderValue
    case toggleIsOn
}

// MARK: - Base Cells
    
open class TableCellBasic: TableCell {
    public weak var delegate: CellDelegate?

    open var userInfo: [AnyHashable: Any] {
        get { return _userInfo }
        set { _userInfo.merge(newValue) { (_, new) in new } }
    }
    private var _userInfo = [AnyHashable: Any]()

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

    @objc open func callback(_ sender: Any) {
        delegate?.callback(from: self, sender: sender)
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

// MARK: - Custom Cells

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
        toggle.addTarget(self, action: #selector(callback(_:)), for: .valueChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? ViewModel {
            textLabel?.text = viewModel.title
            toggle.isOn = viewModel.isOn
        } else {
            super.update(with: item)
        }
    }

    open override func callback(_ sender: Any) {
        userInfo[TableCellUserInfo.toggleIsOn] = toggle.isOn
        super.callback(sender)
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
        toggle.addTarget(self, action: #selector(callback(_:)), for: .valueChanged)
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

    open override func callback(_ sender: Any) {
        userInfo[TableCellUserInfo.toggleIsOn] = toggle.isOn
        super.callback(sender)
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

        slider.addTarget(self, action: #selector(callback(_:)), for: .valueChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? ViewModel {
            slider.value = viewModel.value
        }
    }

    open override func callback(_ sender: Any) {
        userInfo[TableCellUserInfo.sliderValue] = slider.value
        super.callback(sender)
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

        slider.addTarget(self, action: #selector(callback(_:)), for: .valueChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? ViewModel {
            leftLabel.text = viewModel.leftText
            centerLabel.text = viewModel.centerText
            rightLabel.text = viewModel.rightText
            slider.value = viewModel.value
        }
    }

    open override func callback(_ sender: Any) {
        userInfo[TableCellUserInfo.sliderValue] = slider.value
        super.callback(sender)
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
        textField.enforceMinimumHeight()

        textField.addTarget(self, action: #selector(callback(_:)), for: .editingChanged)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? BasicViewModel {
            textField.placeholder = viewModel.title
        }
    }
}

open class TableCellTextView: TableCellBasic, UITextViewDelegate {
    public let textView = UITextView()

    open override func configure() {
        super.configure()

        selectionStyle = .none

        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false

        let margins = contentView.layoutMarginsGuide
        textView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textView.enforceMinimumHeight()

        textView.delegate = self
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? BasicViewModel {
            var text = String()
            if let title = viewModel.title {
                text += title
            }
            if let detail = viewModel.detail {
                text += "\n"
                text += detail
            }
            textView.text = text
        }
    }

    // MARK: UITextViewDelegate

    open func textViewDidChange(_ textView: UITextView) {
        callback(textView)
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
        button.enforceMinimumHeight()

        button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
    }
    open override func update(with item: Item) {
        if let viewModel = item.viewModel as? BasicViewModel {
            button.setTitle(viewModel.title, for: .normal)
        }
    }
}

open class TableCellSpinner: TableCellBasic {
    public let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    open override func configure() {
        super.configure()

        selectionStyle = .none

        contentView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false

        let margins = contentView.layoutMarginsGuide
        spinner.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }

    open override func reset() {
        super.reset()
        spinner.startAnimating()
    }
}

// MARK: - Helpers

extension UIView {
    func enforceMinimumHeight(to height: CGFloat = 44) {
        let height = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        height.priority = .defaultHigh
        height.isActive = true
    }
}
