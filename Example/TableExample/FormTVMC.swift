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
            return .basic
        default:
            return .textInput
        }
    }
    
}
