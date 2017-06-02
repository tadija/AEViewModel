//
//  RegisterTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 5/28/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Table

class RegisterTVC: TableViewController {
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        return .textInput
    }
    
    override func updateCell(_ cell: TableCell, with item: Item) {        
        if let textInputCell = cell as? Cell.TextInput {
            textInputCell.textField.placeholder = item.title
        }
    }
    
}
