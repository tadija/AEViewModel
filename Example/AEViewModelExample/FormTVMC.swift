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
        switch identifier {
        case FormItem.username.rawValue,
             FormItem.password.rawValue:
            return .textInput
        case FormItem.accept.rawValue:
            return .toggle
        case FormItem.register.rawValue:
            return .button
        default:
            return .basic
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
        
        switch item.identifier {
        case FormItem.username.rawValue:
            cell.action = { _ in
                let nextIndexPath = self.nextIndexPath(from: indexPath)
                self.becomeFirstResponder(at: nextIndexPath)
            }
        case FormItem.password.rawValue:
            (cell as? TableCell.TextInput)?.textField.isSecureTextEntry = true
            cell.action = { _ in
                let previousIndexPath = self.previousIndexPath(from: indexPath)
                self.becomeFirstResponder(at: previousIndexPath)
            }
        case FormItem.accept.rawValue:
            cell.action = { sender in
                let enabled = (sender as? UISwitch)?.isOn ?? false
                let nextIndexPath = self.nextIndexPath(from: indexPath)
                self.updateButton(at: nextIndexPath, enabled: enabled)
            }
        case FormItem.register.rawValue:
            (cell as? TableCell.Button)?.button.isEnabled = false
            cell.action = { _ in
                self.presentAlert()
            }
        default:
            break
        }
    }
    
    // MARK: Helpers
    
    private func becomeFirstResponder(at indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        if let cell = tableView.cellForRow(at: indexPath) as? TableCell.TextInput {
            cell.textField.becomeFirstResponder()
        }
    }
    
    private func updateButton(at indexPath: IndexPath?, enabled: Bool) {
        guard let indexPath = indexPath else {
            return
        }
        if let cell = tableView.cellForRow(at: indexPath) as? TableCell.Button {
            cell.button.isEnabled = enabled
        }
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Thank you",
                                      message: "Nice to have you onboard!",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
