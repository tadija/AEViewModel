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
        case FormItem.accept.rawValue:
            return .toggle
        case FormItem.register.rawValue:
            return .button
        default:
            return .textInput
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        switch item.identifier {
        case FormItem.accept.rawValue:
            print("Accept terms toggled")
        case FormItem.register.rawValue:
            print("Register button tapped")
        default:
            print("Handle custom action here")
        }
    }
    
}
