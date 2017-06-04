//
//  ExampleTVMC.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

final class ExampleTMVC: TableViewModelController {
    
    // MARK: Override
    
    override func customInit() {
        table = Example.Table()
    }
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        return .subtitle
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: ItemViewModel, sender: Any) {
        pushTable(from: item, in: FormTVMC())
    }
    
}
