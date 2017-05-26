import UIKit

open class TableViewController: UITableViewController {
    
    public typealias id = Cell.ID
    
    // MARK: Properties
    
    public var table: Table?
    
    // MARK: Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
        commonInit()
    }
    
    public convenience init(style: UITableViewStyle, table: Table) {
        self.init(style: style)
        self.table = table
        commonInit()
    }
    
    public convenience init() {
        self.init(style: .grouped)
        commonInit()
    }
    
    private func commonInit() {
        /// - Note: nothing for now...
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        title = table?.title
        registerCells()
    }
    
    // MARK: Abstract
    
    open func cellUI(forIdentifier identifier: String) -> Cell.UI {
        return .basic
    }
    
    open func updateCell(_ cell: TableCell, with item: Item) {
        cell.updateUI(with: item)
    }
    
    open func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableCell) {
        print("This method is abstract and must be implemented by subclass")
    }
    
    // MARK: API
    
    public func item(from cell: TableCell) -> Item? {
        guard
            let tableViewCell = cell as? UITableViewCell,
            let indexPath = tableView.indexPath(for: tableViewCell),
            let item = table?.item(at: indexPath)
        else { return nil }
        return item
    }
    
    public func pushSubmenu(with table: Table?, in tvc: TableViewController) {
        if let table = table {
            tvc.table = table
            navigationController?.pushViewController(tvc, animated: true)
        }
    }
    
    // MARK: Helpers
    
    private func registerCells() {
        var uniqueIdentifiers: Set<String> = Set<String>()
        table?.sections?.forEach { section in
            if let identifiers = section.items?.flatMap({ $0.identifier }) {
                uniqueIdentifiers.formUnion(identifiers)
            }
        }
        uniqueIdentifiers.forEach { identifier in
            registerCell(with: identifier)
        }
    }
    
    private func registerCell(with identifier: String) {
        switch cellUI(forIdentifier: identifier) {
        case .basic:
            tableView.register(Cell.Basic.self, forCellReuseIdentifier: identifier)
        case .subtitle:
            tableView.register(Cell.Subtitle.self, forCellReuseIdentifier: identifier)
        case .leftDetail:
            tableView.register(Cell.LeftDetail.self, forCellReuseIdentifier: identifier)
        case .rightDetail:
            tableView.register(Cell.RightDetail.self, forCellReuseIdentifier: identifier)
        case .toggle:
            tableView.register(Cell.Toggle.self, forCellReuseIdentifier: identifier)
        case .customClass(let cellClass):
            tableView.register(cellClass, forCellReuseIdentifier: identifier)
        case .customNib(let cellNib):
            tableView.register(cellNib, forCellReuseIdentifier: identifier)
        }
    }
    
}

// MARK: - UITableViewControllerDataSource

extension TableViewController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return table?.sections?.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table?.sections?[section].items?.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = table?.item(at: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)

        (cell as? Cell.Toggle)?.delegate = self
        
        if let cell = cell as? TableCell {
            updateCell(cell, with: item)
        }
        
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return table?.sections?[section].header
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return table?.sections?[section].footer
    }
    
}

// MARK: - UITableViewControllerDelegate

extension TableViewController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let item = table?.item(at: indexPath),
            let cell = tableView.cellForRow(at: indexPath) as? TableCell
        else { return }
        
        handleEvent(.primaryActionTriggered, with: item, sender: cell)
    }
    
}

// MARK: - ToggleCellDelegate

extension TableViewController: ToggleCellDelegate {
    
    public func didChangeValue(sender: Cell.Toggle) {
        if let item = item(from: sender) {
            handleEvent(.valueChanged, with: item, sender: sender)
        }
    }
    
}
