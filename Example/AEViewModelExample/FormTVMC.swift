/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

final class FormTVMC: TableViewModelController, UITextFieldDelegate {
    
    typealias Id = FormViewModel.Id

    // MARK: Propertis

    private var username = String()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FormViewModel()
    }

    // MARK: Override
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        switch identifier {
        case Id.username, Id.password:
            return .textField
        case Id.accept:
            return .toggle
        case Id.register:
            return .button
        default:
            fatalError("Identifier not supported.")
        }
    }
    
    override func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
        let id = viewModel.identifier(at: indexPath)
        switch id {
        case Id.username:
            (cell as? TableCellTextField)?.textField.delegate = self
        case Id.password:
            let textInputCell = (cell as? TableCellTextField)
            textInputCell?.textField.delegate = self
            textInputCell?.textField.isSecureTextEntry = true
        case Id.register:
            (cell as? TableCellButton)?.button.isEnabled = false
        default:
            break
        }
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: Any) {
        let id = viewModel.identifier(at: indexPath)
        switch id {
        case Id.username:
            if let textField = sender as? UITextField {
                username = textField.text ?? String()
            }
        case Id.accept:
            let toggle = (cell as? TableCellToggle)?.toggle
            didToggleAcceptCell(at: indexPath, sender: toggle)
        case Id.register:
            presentAlert()
        default:
            break
        }
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        guard
            let cell = textField.superview?.superview as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            viewModel.identifier(at: indexPath) == Id.username
        else {
            return false
        }

        let nextIndexPath = indexPath.next(in: tableView)
        becomeFirstResponder(at: nextIndexPath)

        return true
    }

    // MARK: Helpers

    @objc
    private func didToggleAcceptCell(at indexPath: IndexPath, sender: UISwitch?) {
        let enabled = sender?.isOn ?? false
        let nextIndexPath = indexPath.next(in: tableView)
        updateButton(at: nextIndexPath, enabled: enabled)
    }

    private func becomeFirstResponder(at indexPath: IndexPath?) {
        if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? TableCellTextField {
            cell.textField.becomeFirstResponder()
        }
    }
    
    private func updateButton(at indexPath: IndexPath?, enabled: Bool) {
        if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? TableCellButton {
            cell.button.isEnabled = enabled
        }
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Thank you \(username)",
                                      message: "Nice to have you onboard!",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
