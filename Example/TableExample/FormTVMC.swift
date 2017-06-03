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
    
    // MARK: Override
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case RegisterSection.AcceptItem.identifier:
            return .toggle
        case RegisterSection.RegisterItem.identifier:
            return .button
        default:
            return .textInput
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: ItemViewModel, sender: TableViewModelCell) {
        switch item.identifier {
        case RegisterSection.RegisterItem.identifier:
            print("Register button tapped")
        default:
            print("Handle custom action here")
        }
    }
    
}
