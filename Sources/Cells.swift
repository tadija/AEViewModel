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

public class RightSwitchCell: UITableViewCell, TableModelCell {
    let switchButton = UISwitch()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    func configureUI() {
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(switchButton)
        switchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17).isActive = true
        switchButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
