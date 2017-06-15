//
//  FormTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import AEViewModel

final class FormTVMC: TableViewModelController {
    
    typealias FormItem = FormTable.ItemType
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        guard let type = FormItem(rawValue: identifier) else {
            return .basic
        }
        switch type {
        case .username, .password:
            return .textInput
        case .accept:
            return .toggle
        case .register:
            return .button
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
        
        guard let type = FormItem(rawValue: item.identifier) else {
            return
        }
        switch type {
        case .username:
            cell.action = { _ in
                let nextIndexPath = self.nextIndexPath(from: indexPath)
                self.becomeFirstResponder(at: nextIndexPath)
            }
        case .password:
            (cell as? TableCell.TextInput)?.textField.isSecureTextEntry = true
            cell.action = { _ in
                let previousIndexPath = self.previousIndexPath(from: indexPath)
                self.becomeFirstResponder(at: previousIndexPath)
            }
        case .accept:
            cell.action = { sender in
                let enabled = (sender as? UISwitch)?.isOn ?? false
                let nextIndexPath = self.nextIndexPath(from: indexPath)
                self.updateButton(at: nextIndexPath, enabled: enabled)
            }
        case .register:
            (cell as? TableCell.Button)?.button.isEnabled = false
            cell.action = { _ in
                self.presentAlert()
            }
        }
    }
    
    // MARK: Helpers
    
    private func becomeFirstResponder(at indexPath: IndexPath?) {
        if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? TableCell.TextInput {
            cell.textField.becomeFirstResponder()
        }
    }
    
    private func updateButton(at indexPath: IndexPath?, enabled: Bool) {
        if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? TableCell.Button {
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
