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
    
    typealias RegisterItem = Form.Section.Register.Item
    
    // MARK: Override
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case RegisterItem.Accept.identifier:
            return .toggle
        case RegisterItem.Register.identifier:
            return .button
        default:
            return .textInput
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: ItemViewModel, sender: Any) {
        switch item.identifier {
        case RegisterItem.Accept.identifier:
            print("Accept terms toggled")
        case RegisterItem.Register.identifier:
            print("Register button tapped")
        default:
            print("Handle custom action here")
        }
    }
    
}
