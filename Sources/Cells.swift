import UIKit

public class DefaultCell: UITableViewCell, TableModelCell {
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
}

public class SubtitleCell: UITableViewCell, TableModelCell {
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
}

public class LeftDetailCell: UITableViewCell, TableModelCell {
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
}

public class RightDetailCell: UITableViewCell, TableModelCell {
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
}

public protocol ToggleCellDelegate: class {
    func didChangeValue(sender: ToggleCell)
}

public class ToggleCell: UITableViewCell, TableModelCell {
    public let toggle = UISwitch()
    public weak var delegate: ToggleCellDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(callDelegate), for: .valueChanged)
    }
    
    func callDelegate() {
        delegate?.didChangeValue(sender: self)
    }
}
