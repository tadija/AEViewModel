/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

open class TableViewModelController: UITableViewController, ViewModelCellDelegate {
    
    // MARK: Properties

    open var isAutomaticReloadEnabled = true

    open var viewModel: ViewModel = BasicViewModel() {
        didSet {
            if isAutomaticReloadEnabled {
                reload()
            }
        }
    }
    
    // MARK: Init

    public convenience init() {
        self.init(viewModel: BasicViewModel(), style: .grouped)
    }
    
    public convenience init(viewModel: ViewModel, style: UITableViewStyle = .grouped) {
        self.init(style: style)
        self.viewModel = viewModel
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

    open func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath)
        cell.update(with: item)
        cell.delegate = self
    }

    open func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: Any) {}

    // MARK: ViewModelCellDelegate

    public func action(for cell: ViewModelCell, sender: Any) {
        if let cell = cell as? TableViewModelCell, let indexPath = tableView.indexPath(for: cell) {
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
        if let title = viewModel.title {
            self.title = title
        }
        registerCells()
        tableView.reloadData()
    }
    
    private func registerCells() {
        viewModel.uniqueIdentifiers.forEach { id in
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
        case .button:
            tableView.register(TableCellButton.self, forCellReuseIdentifier: identifier)
        case .toggle:
            tableView.register(TableCellToggle.self, forCellReuseIdentifier: identifier)
        case .toggleSubtitle:
            tableView.register(TableCellToggleSubtitle.self, forCellReuseIdentifier: identifier)
        case .textInput:
            tableView.register(TableCellTextInput.self, forCellReuseIdentifier: identifier)
        case .slider:
            tableView.register(TableCellSlider.self, forCellReuseIdentifier: identifier)
        case .sliderLabels:
            tableView.register(TableCellSliderLabels.self, forCellReuseIdentifier: identifier)
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
        return viewModel.sections.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = viewModel.identifier(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        if let cell = cell as? TableViewModelCell {
            update(cell, at: indexPath)
        }
        return cell
    }

    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].header
    }

    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.sections[section].footer
    }
    
}

// MARK: - UITableViewControllerDelegate

extension TableViewModelController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewModelCell else {
            return
        }
        if cell.selectionStyle != .none {
            action(for: cell, at: indexPath, sender: self)
        }
    }
    
}
