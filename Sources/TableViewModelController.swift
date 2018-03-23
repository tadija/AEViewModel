/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

public protocol TableViewModelControllerDelegate: class {
    func cellType(forIdentifier identifier: String) -> TableCellType
    func update(_ cell: TableViewModelCell, at indexPath: IndexPath)
    func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: TableViewModelController)
}

open class TableViewModelController: UITableViewController, TableViewModelControllerDelegate {
    
    // MARK: Properties

    public weak var delegate: TableViewModelControllerDelegate?

    open var isAutomaticReloadEnabled = true

    open var dataSource: DataSource = BasicDataSource() {
        didSet {
            if isAutomaticReloadEnabled {
                reload()
            }
        }
    }
    
    // MARK: Init

    public convenience init() {
        self.init(dataSource: BasicDataSource(), style: .grouped)
    }
    
    public convenience init(dataSource: DataSource, style: UITableViewStyle = .grouped) {
        self.init(style: style)
        self.dataSource = dataSource
    }
    
    // MARK: Lifecycle

    open override func loadView() {
        super.loadView()
        if delegate == nil {
            delegate = self
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    // MARK: TableViewModelControllerDelegate

    open func cellType(forIdentifier identifier: String) -> TableCellType {
        return .basic
    }

    open func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        let item = dataSource.item(at: indexPath)
        cell.update(with: item)
        cell.callback = { [unowned self] sender in
            self.delegate?.action(for: cell, at: indexPath, sender: self)
        }
    }

    open func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: TableViewModelController) {}

    // MARK: Helpers
    
    private func reload() {
        if Thread.isMainThread {
            registerCells()
            tableView.reloadData()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.registerCells()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func registerCells() {
        dataSource.uniqueIdentifiers.forEach { id in
            registerCell(with: id)
        }
    }
    
    private func registerCell(with identifier: String) {
        guard let delegate = delegate else {
            fatalError("Delegate must be provided by now.")
        }
        switch delegate.cellType(forIdentifier: identifier) {
        case .basic:
            tableView.register(TableCellBasic.self, forCellReuseIdentifier: identifier)
        case .subtitle:
            tableView.register(TableCellSubtitle.self, forCellReuseIdentifier: identifier)
        case .leftDetail:
            tableView.register(TableCellLeftDetail.self, forCellReuseIdentifier: identifier)
        case .rightDetail:
            tableView.register(TableCellRightDetail.self, forCellReuseIdentifier: identifier)
        case .button:
            tableView.register(TableCellButton.self, forCellReuseIdentifier: identifier)
        case .toggleBasic:
            tableView.register(TableCellToggleBasic.self, forCellReuseIdentifier: identifier)
        case .toggleSubtitle:
            tableView.register(TableCellToggleSubtitle.self, forCellReuseIdentifier: identifier)
        case .textInput:
            tableView.register(TableCellTextInput.self, forCellReuseIdentifier: identifier)
        case .customClass(let cellClass):
            tableView.register(cellClass, forCellReuseIdentifier: identifier)
        case .customNib(let cellClass):
            tableView.register(cellClass.nib, forCellReuseIdentifier: identifier)
        }
    }
    
}

// MARK: - UITableViewControllerDataSource

extension TableViewModelController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = dataSource.identifier(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        if let cell = cell as? TableViewModelCell {
            delegate?.update(cell, at: indexPath)
        }
        return cell
    }
    
}

// MARK: - UITableViewControllerDelegate

extension TableViewModelController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewModelCell else {
            return
        }
        if cell.selectionStyle != .none {
            delegate?.action(for: cell, at: indexPath, sender: self)
        }
    }
    
}
