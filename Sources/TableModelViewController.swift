import UIKit

public protocol TableModelDelegate: class {
    func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle
    func handleAction(with item: Item, from cell: TableModelCell?)
}

open class TableModelViewController: UITableViewController, TableModelDelegate {
    public var model: TableModel!
    public weak var modelDelegate: TableModelDelegate?
    var cellDelegates = [String : Any]()
    
    public convenience init(style: UITableViewStyle, model: TableModel) {
        self.init(style: style)
        self.model = model
        self.modelDelegate = self
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        title = model.title
        registerCells()
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
            case .toggle(let toggleDelegate):
                cellDelegates[identifier] = toggleDelegate
                tableView.register(ToggleCell.self, forCellReuseIdentifier: identifier)
            case .customClass(let cellClass):
                tableView.register(cellClass, forCellReuseIdentifier: identifier)
            case .customNib(let cellNib):
                tableView.register(cellNib, forCellReuseIdentifier: identifier)
            }
        } else {
            tableView.register(DefaultCell.self, forCellReuseIdentifier: identifier)
        }
    }
    
    open func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        fatalError("This method is abstract and must be implemented by subclass")
    }
    
    open func handleAction(with item: Item, from cell: TableModelCell?) {
        fatalError("This method is abstract and must be implemented by subclass")
    }
}

extension TableModelViewController {
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return model.sections.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.sections[section].items.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = model.item(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        if let toggleCell = cell as? ToggleCell {
            toggleCell.delegate = cellDelegates[item.identifier] as? ToggleCellDelegate
        }
        if let cell = cell as? TableModelCell {
            cell.configure(with: item)
        }
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.sections[section].headerTitle
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return model.sections[section].footerTitle
    }
}

extension TableModelViewController {
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = model.item(at: indexPath)
        let cell = tableView.cellForRow(at: indexPath) as? TableModelCell
        modelDelegate?.handleAction(with: item, from: cell)
    }
}