import UIKit

open class BaseTableCell: UITableViewCell, TableModelCell {
    
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
    
    // MARK: - TableModelCell
    
    open func configureUI() {}
    
    open func updateUI(with item: Item) {
        imageView?.image = item.image
        textLabel?.text = item.title
        detailTextLabel?.text = item.detail
        
        if (item.submodel?.sections?.count ?? 0) > 0 {
            accessoryType = .disclosureIndicator
        }
    }
    
}

open class SubtitleTableCell: BaseTableCell {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
}

open class LeftDetailTableCell: BaseTableCell {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
}

open class RightDetailTableCell: BaseTableCell {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
}

public protocol ToggleTableCellDelegate: class {
    func didChangeValue(sender: ToggleTableCell)
}

open class ToggleTableCell: BaseTableCell {
    
    // MARK: - Outlets
    
    public let toggle = UISwitch()
    
    // MARK: - Properties
    
    public weak var delegate: ToggleTableCellDelegate?
    
    // MARK: - TableModelCell
    
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
