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
    
    override func updateCell(_ cell: TableViewModelCell, with item: Item) {
        super.updateCell(cell, with: item)
        
        switch item.identifier {
        case FormItem.username.rawValue:
            cell.action = {
                print("Handle custom action here")
            }
        case FormItem.password.rawValue:
            (cell as? TableCell.TextInput)?.textField.isSecureTextEntry = true
            cell.action = {
                print("Handle custom action here")
            }
        case FormItem.accept.rawValue:
            cell.action = {
                print("Accept terms toggled")
            }
        case FormItem.register.rawValue:
            cell.action = {
                print("Register button tapped")
                self.presentAlert()
            }
        default:
            break
        }
    }
    
    // MARK: Helpers
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Thank you",
                                      message: "Nice to have you onboard!",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
