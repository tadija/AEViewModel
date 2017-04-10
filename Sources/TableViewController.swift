import UIKit

public protocol TableModelDelegate: class {
    func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle
}

open class TableViewController: UITableViewController {
    
    public let model: TableModel
    public weak var modelDelegate: TableModelDelegate?
    
    public init(model: TableModel, style: UITableViewStyle = .grouped, modelDelegate: TableModelDelegate) {
        self.model = model
        self.modelDelegate = modelDelegate
        
        super.init(style: style)
        
        self.title = model.title
        registerCells()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        var uniqueIdentifiers: Set<String> = Set<String>()
        model.sections.forEach { section in
            let identifiers = section.items.map{ $0.identifier }
            uniqueIdentifiers.formUnion(identifiers)
        }
        uniqueIdentifiers.forEach { identifier in
            registerCell(with: identifier)
        }
    }
    
    private func registerCell(with identifier: String) {
        if let style = modelDelegate?.cellStyle(forIdentifier: identifier) {
            switch style {
            case .default:
                tableView.register(DefaultCell.self, forCellReuseIdentifier: identifier)
            case .subtitle:
                tableView.register(SubtitleCell.self, forCellReuseIdentifier: identifier)
            case .leftDetail:
                tableView.register(LeftDetailCell.self, forCellReuseIdentifier: identifier)
            case .rightDetail:
                tableView.register(RightDetailCell.self, forCellReuseIdentifier: identifier)
            case .rightSwitch:
                /// - TODO: implement `RightSwitchCell` later
                tableView.register(DefaultCell.self, forCellReuseIdentifier: identifier)
            case .customClass(let cellClass):
                tableView.register(cellClass, forCellReuseIdentifier: identifier)
            case .customNib(let cellNib):
                tableView.register(cellNib, forCellReuseIdentifier: identifier)
            }
        } else {
            tableView.register(DefaultCell.self, forCellReuseIdentifier: identifier)
        }
    }
    
}

extension TableViewController {
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return model.sections.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.sections[section].items.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = model.item(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        if let cell = cell as? TableModelCell {
            cell.configure(with: item)
        }
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.sections[section].data?["header-title"] as? String
    }
}
