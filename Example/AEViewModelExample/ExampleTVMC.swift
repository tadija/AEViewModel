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
    
    // MARK: Override
    
    override func customInit() {
        model = ExampleTable()
    }
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .subtitle
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        switch item.identifier {
        case ExampleTable.ItemType.form.rawValue:
            pushTable(from: item, in: FormTVMC())
        case ExampleTable.ItemType.settings.rawValue:
            pushTable(from: item, in: SettingsTVMC())
        default:
            break
        }
    }
    
}
