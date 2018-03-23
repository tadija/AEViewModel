/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

final class FormTVMC: TableViewModelController {
    
    typealias FormCell = FormTable.Cell
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Registration"
        dataSource = FormTable()
    }

    // MARK: TableViewModelControllerDelegate
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        guard let formCell = FormCell(rawValue: identifier) else {
            return .basic
        }
        switch formCell {
        case .username, .password:
            return .textInput
        case .accept:
            return .toggleBasic
        case .register:
            return .button
        }
    }
    
    override func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)

        let id = dataSource.identifier(at: indexPath)
        guard let formCell = FormCell(rawValue: id) else {
            return
        }
        switch formCell {
        case .password:
            (cell as? TableCellTextInput)?.textField.isSecureTextEntry = true
        case .register:
            (cell as? TableCellButton)?.button.isEnabled = false
        case .username, .accept:
            break
        }
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: TableViewModelController) {
        let id = dataSource.identifier(at: indexPath)
        guard let cellType = FormCell(rawValue: id) else {
            return
        }
        switch cellType {
        case .username:
            let nextIndexPath = indexPath.next(in: tableView)
            becomeFirstResponder(at: nextIndexPath)
        case .password:
            let previousIndexPath = indexPath.previous(in: tableView)
            becomeFirstResponder(at: previousIndexPath)
        case .accept:
            let toggle = (cell as? TableCellToggle)?.toggle
            didToggleAcceptCell(at: indexPath, sender: toggle)
            break
        case .register:
            presentAlert()
        }
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (dataSource.sections[section] as? FormSection)?.header
    }
    
    // MARK: Helpers

    @objc
    private func didToggleAcceptCell(at indexPath: IndexPath, sender: UISwitch?) {
        let enabled = sender?.isOn ?? false
        let nextIndexPath = indexPath.next(in: tableView)
        updateButton(at: nextIndexPath, enabled: enabled)
    }

    private func becomeFirstResponder(at indexPath: IndexPath?) {
        if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? TableCellTextInput {
            cell.textField.becomeFirstResponder()
        }
    }
    
    private func updateButton(at indexPath: IndexPath?, enabled: Bool) {
        if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? TableCellButton {
            cell.button.isEnabled = enabled
        }
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Thank you",
                                      message: "Nice to have you onboard!",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
