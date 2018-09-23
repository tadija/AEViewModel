/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

open class TableViewController: UITableViewController, CellDelegate {
    
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

    public convenience init() {
        self.init(dataSource: BasicDataSource(), style: .grouped)
    }
    
    public convenience init(dataSource: DataSource, style: UITableView.Style = .grouped) {
        self.init(style: style)
        self.dataSource = dataSource
    }
    
    // MARK: Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    // MARK: API

    open func cellType(forIdentifier identifier: String) -> TableCellType {
        return .basic
    }

    open func update(_ cell: TableCell, at indexPath: IndexPath) {
        let item = dataSource.item(at: indexPath)
        cell.update(with: item)
        cell.delegate = self
    }

    open func action(for cell: TableCell, at indexPath: IndexPath, sender: Any) {}

    // MARK: CellDelegate

    public func callback(from cell: Cell, sender: Any) {
        if let cell = cell as? TableCell, let indexPath = tableView.indexPath(for: cell) {
            action(for: cell, at: indexPath, sender: sender)
        }
    }

    // MARK: Helpers
    
    private func reload() {
        if Thread.isMainThread {
            performReload()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.performReload()
            }
        }
    }

    private func performReload() {
        if let title = dataSource.title {
            self.title = title
        }
        registerCells()
        tableView.reloadData()
    }
    
    private func registerCells() {
        dataSource.uniqueIdentifiers.forEach { id in
            registerCell(with: id)
        }
    }
    
    private func registerCell(with identifier: String) {
        switch cellType(forIdentifier: identifier) {
        case .basic:
            tableView.register(TableCellBasic.self, forCellReuseIdentifier: identifier)
        case .subtitle:
            tableView.register(TableCellSubtitle.self, forCellReuseIdentifier: identifier)
        case .leftDetail:
            tableView.register(TableCellLeftDetail.self, forCellReuseIdentifier: identifier)
        case .rightDetail:
            tableView.register(TableCellRightDetail.self, forCellReuseIdentifier: identifier)
        case .toggle:
            tableView.register(TableCellToggle.self, forCellReuseIdentifier: identifier)
        case .toggleWithSubtitle:
            tableView.register(TableCellToggleWithSubtitle.self, forCellReuseIdentifier: identifier)
        case .slider:
            tableView.register(TableCellSlider.self, forCellReuseIdentifier: identifier)
        case .sliderWithLabels:
            tableView.register(TableCellSliderWithLabels.self, forCellReuseIdentifier: identifier)
        case .textField:
            tableView.register(TableCellTextField.self, forCellReuseIdentifier: identifier)
        case .textView:
            tableView.register(TableCellTextView.self, forCellReuseIdentifier: identifier)
        case .button:
            tableView.register(TableCellButton.self, forCellReuseIdentifier: identifier)
        case .spinner:
            tableView.register(TableCellSpinner.self, forCellReuseIdentifier: identifier)
        case .customClass(let cellClass):
            tableView.register(cellClass, forCellReuseIdentifier: identifier)
        case .customNib(let cellClass):
            tableView.register(cellClass.nib, forCellReuseIdentifier: identifier)
        }
    }
    
}

// MARK: - UITableViewControllerDataSource

extension TableViewController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = dataSource.identifier(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        if let cell = cell as? TableCell {
            update(cell, at: indexPath)
        }
        return cell
    }

    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.sections[section].header
    }

    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource.sections[section].footer
    }
    
}

// MARK: - UITableViewControllerDelegate

extension TableViewController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TableCell else {
            return
        }
        if cell.selectionStyle != .none {
            action(for: cell, at: indexPath, sender: self)
        }
    }
    
}
