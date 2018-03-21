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
    }
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
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
    
    override func configureCell(_ cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath) {
        super.configureCell(cell, at: indexPath)

        let identifier = model.identifier(at: indexPath)
        guard let formCell = FormCell(rawValue: identifier) else {
            return
        }
        
        switch formCell {
        case .username:
            cell.action = { _ in
                let nextIndexPath = indexPath.next(in: self.tableView)
                self.becomeFirstResponder(at: nextIndexPath)
            }
        case .password:
            (cell as? TableCellTextInput)?.textField.isSecureTextEntry = true
            cell.action = { _ in
                let previousIndexPath = indexPath.previous(in: self.tableView)
                self.becomeFirstResponder(at: previousIndexPath)
            }
        case .accept:
            cell.action = { sender in
                let enabled = (sender as? UISwitch)?.isOn ?? false
                let nextIndexPath = indexPath.next(in: self.tableView)
                self.updateButton(at: nextIndexPath, enabled: enabled)
            }
        case .register:
            (cell as? TableCellButton)?.button.isEnabled = false
            cell.action = { _ in
                self.presentAlert()
            }
        }
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (model.sections[section] as? FormSection)?.header
    }
    
    // MARK: Helpers
    
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
