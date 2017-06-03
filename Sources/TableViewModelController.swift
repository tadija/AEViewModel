import UIKit

open class TableViewModelController: UITableViewController {
    
    public typealias id = Cell.ID
    
    // MARK: Properties
    
    open var table: TableViewModel?
    
    // MARK: Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
        customInit()
    }
    
    public convenience init(style: UITableViewStyle, viewModel: TableViewModel) {
        self.init(style: style)
        self.table = viewModel
        customInit()
    }
    
    public convenience init() {
        self.init(style: .grouped)
        customInit()
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        title = table?.title
        registerCells()
    }
    
    // MARK: Abstract
    
    open func customInit() {}
    
    open func cellUI(forIdentifier identifier: String) -> Cell.UI {
        return .basic
    }
    
    open func updateCell(_ cell: TableCell, with item: ItemViewModel) {
        cell.updateUI(with: item)
    }
    
    open func handleEvent(_ event: UIControlEvents, with item: ItemViewModel, sender: TableCell) {
        print("This method is abstract and must be implemented by subclass")
    }
    
    // MARK: API
    
    public func item(from cell: TableCell) -> ItemViewModel? {
        guard
            let tableViewCell = cell as? UITableViewCell,
            let indexPath = tableView.indexPath(for: tableViewCell),
            let item = table?.item(at: indexPath)
        else { return nil }
        return item
    }
    
    public func pushTable(from item: ItemViewModel, in tvmc: TableViewModelController) {
        if let table = item.table {
            tvmc.table = table
            navigationController?.pushViewController(tvmc, animated: true)
        }
    }
    
    // MARK: Helpers
    
    private func registerCells() {
        var uniqueIdentifiers: Set<String> = Set<String>()
        table?.sections.forEach { section in
            let sectionIdentifiers = section.items.flatMap({ $0.identifier })
            uniqueIdentifiers.formUnion(sectionIdentifiers)
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
        case .textInput:
            tableView.register(Cell.TextInput.self, forCellReuseIdentifier: identifier)
        case .customClass(let cellClass):
            tableView.register(cellClass, forCellReuseIdentifier: identifier)
        case .customNib(let cellNib):
            tableView.register(cellNib, forCellReuseIdentifier: identifier)
        }
    }
    
}

// MARK: - UITableViewControllerDataSource

extension TableViewModelController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return table?.sections.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table?.sections[section].items.count ?? 0
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
        return table?.sections[section].header
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return table?.sections[section].footer
    }
    
}

// MARK: - UITableViewControllerDelegate

extension TableViewModelController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let item = table?.item(at: indexPath),
            let cell = tableView.cellForRow(at: indexPath) as? TableCell
        else { return }
        
        handleEvent(.primaryActionTriggered, with: item, sender: cell)
    }
    
}

// MARK: - ToggleCellDelegate

extension TableViewModelController: ToggleCellDelegate {
    
    public func didChangeValue(sender: Cell.Toggle) {
        if let item = item(from: sender) {
            handleEvent(.valueChanged, with: item, sender: sender)
        }
    }
    
}
