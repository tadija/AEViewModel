import UIKit

public protocol TableCell: class {
    func configureUI()
    func updateUI(with item: Item)
}

open class TableCellBase: UITableViewCell, TableCell {
    
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
        
        if (item.submodel?.sections?.count ?? 0) > 0 {
            accessoryType = .disclosureIndicator
        }
    }
    
}

open class TableCellSubtitle: TableCellBase {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
}

open class TableCellLeftDetail: TableCellBase {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
}

open class TableCellRightDetail: TableCellBase {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
}

public protocol TableCellToggleDelegate: class {
    func didChangeValue(sender: TableCellToggle)
}

open class TableCellToggle: TableCellBase {
    
    // MARK: - Outlets
    
    public let toggle = UISwitch()
    
    // MARK: - Properties
    
    public weak var delegate: TableCellToggleDelegate?
    
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
