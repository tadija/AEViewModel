//
//  FormTVMC.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

final class FormTVMC: TableViewModelController {
    
    // MARK: Types
    
    typealias ActionItem = FormTable.Action
    
    // MARK: Override
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case ActionItem.Accept.identifier:
            return .toggle
        case ActionItem.Register.identifier:
            return .button
        default:
            return .textInput
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: ItemViewModel, sender: Any) {
        switch item.identifier {
        case ActionItem.Accept.identifier:
            print("Accept terms toggled")
        case ActionItem.Register.identifier:
            print("Register button tapped")
        default:
            print("Handle custom action here")
        }
    }
    
}
