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
    
    typealias Action = FormTable.Action
    
    // MARK: Override
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case Action.Accept.identifier:
            return .toggle
        case Action.Register.identifier:
            return .button
        default:
            return .textInput
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        switch item.identifier {
        case Action.Accept.identifier:
            print("Accept terms toggled")
        case Action.Register.identifier:
            print("Register button tapped")
        default:
            print("Handle custom action here")
        }
    }
    
}
