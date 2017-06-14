//
//  ExampleTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import AEViewModel

final class ExampleTVMC: TableViewModelController {
    
    typealias ExampleItem = ExampleTable.ItemType
    
    // MARK: Override
    
    override func customInit() {
        model = ExampleTable()
    }
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .subtitle
    }
    
    override func configureCell(_ cell: TableViewModelCell, with item: Item, at indexPath: IndexPath) {
        super.configureCell(cell, with: item, at: indexPath)
        
        switch item.identifier {
        case ExampleItem.form.rawValue:
            cell.action = {
                self.pushTable(from: item, in: FormTVMC())
            }
        case ExampleItem.settings.rawValue:
            cell.action = {
                self.pushTable(from: item, in: SettingsTVMC())
            }
        default:
            break
        }
    }
    
}
