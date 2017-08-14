import UIKit

open class TableViewModelController: UITableViewController {
    
    // MARK: Properties
    
    open var model: Table? {
        didSet {
            configureTableView()
            didUpdateModel()
        }
    }
    
    // MARK: Init
    
    public convenience init(style: UITableViewStyle, model: Table) {
        self.init(style: style)
        self.model = model
    }
    
    public convenience init() {
        self.init(style: .grouped)
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    // MARK: Abstract
    
    open func didUpdateModel() {
        if model != nil {
            tableView.reloadData()
        }
    }
    
    open func cell(forIdentifier identifier: String) -> TableCell {
        return .basic
    }
    
    open func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        if let item = model?.item(at: indexPath) {
            cell.update(with: item)
        }
    }
    
    // MARK: API
    
    public func item(from cell: TableViewModelCell) -> Item? {
        guard
            let tableViewCell = cell as? UITableViewCell,
            let indexPath = tableView.indexPath(for: tableViewCell),
            let item = model?.item(at: indexPath)
        else { return nil }
        return item
    }
    
    public func pushTable(from item: Item, in tvmc: TableViewModelController) {
        if let model = item.child as? Table {
            tvmc.model = model
            navigationController?.pushViewController(tvmc, animated: true)
        }
    }
    
    public func nextIndexPath(from indexPath: IndexPath) -> IndexPath? {
        var newIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        if newIndexPath.row >= tableView(tableView, numberOfRowsInSection: indexPath.section) {
            let newSection = indexPath.section + 1
            newIndexPath = IndexPath(row: 0, section: newSection)
            if newSection >= numberOfSections(in: tableView) {
                return nil
            }
        }
        return newIndexPath
    }
    
    public func previousIndexPath(from indexPath: IndexPath) -> IndexPath? {
        var newIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        if newIndexPath.row < 0 {
            let newSection = indexPath.section - 1
            if newSection < 0 {
                return nil
            }
            let maxRow = tableView(tableView, numberOfRowsInSection: newSection) - 1
            newIndexPath = IndexPath(row: maxRow, section: newSection)
        }
        return newIndexPath
    }
    
    // MARK: Helpers
    
    private func configureTableView() {
        title = model?.title
        registerCells()
    }
    
    private func registerCells() {
        var uniqueIdentifiers: Set<String> = Set<String>()
        model?.sections.forEach { section in
            let sectionIdentifiers: [String] = section.items.flatMap({ $0.identifier })
            uniqueIdentifiers.formUnion(sectionIdentifiers)
        }
        uniqueIdentifiers.forEach { identifier in
            registerCell(with: identifier)
        }
    }
    
    private func registerCell(with identifier: String) {
        switch cell(forIdentifier: identifier) {
        case .basic:
            tableView.register(TableCell.Basic.self, forCellReuseIdentifier: identifier)
        case .subtitle:
            tableView.register(TableCell.Subtitle.self, forCellReuseIdentifier: identifier)
        case .leftDetail:
            tableView.register(TableCell.LeftDetail.self, forCellReuseIdentifier: identifier)
        case .rightDetail:
            tableView.register(TableCell.RightDetail.self, forCellReuseIdentifier: identifier)
        case .button:
            tableView.register(TableCell.Button.self, forCellReuseIdentifier: identifier)
        case .toggle:
            tableView.register(TableCell.Toggle.self, forCellReuseIdentifier: identifier)
        case .textInput:
            tableView.register(TableCell.TextInput.self, forCellReuseIdentifier: identifier)
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
        return model?.sections.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.sections[section].items.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model?.item(at: indexPath) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        if let cell = cell as? TableViewModelCell {
            configureCell(cell, at: indexPath)
        }
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.sections[section].header
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return model?.sections[section].footer
    }
    
}

// MARK: - UITableViewControllerDelegate

extension TableViewModelController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath),
            let tableViewModelCell = cell as? TableViewModelCell
        else { return }
        
        if cell.selectionStyle != .none {
            tableViewModelCell.action(cell)
        }
    }
    
}
