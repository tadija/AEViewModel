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
        return .textInput
    }
    
    override func updateCell(_ cell: TableViewModelCell, with item: ItemViewModel) {
        /// - Note: check alternative to this logic
        if let textInputCell = cell as? Cell.TextInput {
            textInputCell.textField.placeholder = item.model.title
        }
    }
    
}
