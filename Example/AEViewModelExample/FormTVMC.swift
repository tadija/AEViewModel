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
        
        if item.identifier == FormItem.password.rawValue, let cell = cell as? TableCell.TextInput {
            cell.textField.isSecureTextEntry = true
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        switch item.identifier {
        case FormItem.username.rawValue,
             FormItem.password.rawValue:
            print("Handle custom action here")
        case FormItem.accept.rawValue:
            print("Accept terms toggled")
        case FormItem.register.rawValue:
            print("Register button tapped")
            presentAlert()
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
