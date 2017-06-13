//
//  FormTVMC.swift
//  AETableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import AETable

final class FormTVMC: TableViewModelController {
    
    // MARK: Override
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case FormTable.ItemType.accept.rawValue:
            return .toggle
        case FormTable.ItemType.register.rawValue:
            return .button
        default:
            return .textInput
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        switch item.identifier {
        case FormTable.ItemType.accept.rawValue:
            print("Accept terms toggled")
        case FormTable.ItemType.register.rawValue:
            print("Register button tapped")
        default:
            print("Handle custom action here")
        }
    }
    
}
