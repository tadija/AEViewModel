/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

final class FormTVMC: TableViewModelController {
    
    typealias Id = FormDataSource.Id
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = FormDataSource()
    }

    // MARK: TableViewModelControllerDelegate
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        switch identifier {
        case Id.username, Id.password:
            return .textInput
        case Id.accept:
            return .toggleBasic
        case Id.register:
            return .button
        default:
            fatalError("Identifier not supported.")
        }
    }
    
    override func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
        let id = dataSource.identifier(at: indexPath)
        switch id {
        case Id.password:
            (cell as? TableCellTextInput)?.textField.isSecureTextEntry = true
        case Id.register:
            (cell as? TableCellButton)?.button.isEnabled = false
        default:
            break
        }
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath) {
        let id = dataSource.identifier(at: indexPath)
        switch id {
        case Id.username:
            let nextIndexPath = indexPath.next(in: tableView)
            becomeFirstResponder(at: nextIndexPath)
        case Id.password:
            let previousIndexPath = indexPath.previous(in: tableView)
            becomeFirstResponder(at: previousIndexPath)
        case Id.accept:
            let toggle = (cell as? TableCellToggle)?.toggle
            didToggleAcceptCell(at: indexPath, sender: toggle)
        case Id.register:
            presentAlert()
        default:
            break
        }
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
