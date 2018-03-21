/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

open class TableViewModelController: UITableViewController {
    
    // MARK: Properties

    open var isAutomaticReloadEnabled = true

    open var dataSource: DataSource = BasicDataSource() {
        didSet {
            if isAutomaticReloadEnabled {
                reload()
            }
        }
    }
    
    // MARK: Init
    
    public convenience init(style: UITableViewStyle, dataSource: DataSource) {
        self.init(style: style)
        self.dataSource = dataSource
    }
    
    public convenience init() {
        self.init(style: .grouped)
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
    }
    
    // MARK: Abstract
    
    open func cell(forIdentifier identifier: String) -> TableCell {
        return .basic
    }
    
    open func configureCell(_ cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath) {
        let item = dataSource.item(at: indexPath)
        cell.update(with: item)
    }
    
    // MARK: Helpers
    
    private func reload() {
        if Thread.isMainThread {
            registerCellsAndReloadDataIfNeeded()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.registerCellsAndReloadDataIfNeeded()
            }
        }
    }
    
    private func registerCellsAndReloadDataIfNeeded() {
        registerCells()
        tableView.reloadData()
    }
    
    private func registerCells() {
        dataSource.uniqueIdentifiers.forEach { identifier in
            registerCell(with: identifier)
        }
    }
    
    private func registerCell(with identifier: String) {
        switch cell(forIdentifier: identifier) {
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
        case .customNib(let cellNib):
            tableView.register(cellNib, forCellReuseIdentifier: identifier)
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
        let identifier = dataSource.identifier(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = cell as? UITableViewCell & TableViewModelCell {
            configureCell(cell, at: indexPath)
        }
        return cell
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
