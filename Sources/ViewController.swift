import UIKit

open class ViewController: UITableViewController {
    
    // MARK: - Types
    
    public struct id {}
    
    // MARK: - Properties
    
    public var model: Table?
    
    // MARK: - Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
        commonInit()
    }
    
    public convenience init(style: UITableViewStyle, model: Table) {
        self.init(style: style)
        self.model = model
        commonInit()
    }
    
    private func commonInit() {
        /// - Note: nothing for now...
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        title = model?.title
        registerCells()
    }
    
    // MARK: - Abstract
    
    open func cellType(forIdentifier identifier: String) -> Cell.`Type` {
        return .basic
    }
    
    open func updateCell(_ cell: TableCell, with item: Item) {
        cell.updateUI(with: item)
    }
    
    open func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableCell) {
        print("This method is abstract and must be implemented by subclass")
    }
    
    // MARK: - API
    
    public func item(from cell: TableCell) -> Item? {
        guard
            let tableViewCell = cell as? UITableViewCell,
            let indexPath = tableView.indexPath(for: tableViewCell),
            let item = model?.item(at: indexPath)
        else { return nil }
        return item
    }
    
    // MARK: - Helpers
    
    private func registerCells() {
        var uniqueIdentifiers: Set<String> = Set<String>()
        model?.sections?.forEach { section in
            if let identifiers = section.items?.flatMap({ $0.identifier }) {
                uniqueIdentifiers.formUnion(identifiers)
            }
        }
        uniqueIdentifiers.forEach { identifier in
            registerCell(with: identifier)
        }
    }
    
    private func registerCell(with identifier: String) {
        switch cellType(forIdentifier: identifier) {
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

extension ViewController {
    
    // MARK: - UITableViewControllerDataSource
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.sections?.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.sections?[section].items?.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model?.item(at: indexPath) else {
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
        return model?.sections?[section].header
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return model?.sections?[section].footer
    }
    
}

extension ViewController {
    
    // MARK: - UITableViewControllerDelegate
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let item = model?.item(at: indexPath),
            let cell = tableView.cellForRow(at: indexPath) as? TableCell
        else { return }
        
        handleEvent(.primaryActionTriggered, with: item, sender: cell)
    }
    
}

extension ViewController: ToggleCellDelegate {
    
    // MARK: - ToggleCellDelegate
    
    public func didChangeValue(sender: Cell.Toggle) {
        if let item = item(from: sender) {
            handleEvent(.valueChanged, with: item, sender: sender)
        }
    }
    
}
