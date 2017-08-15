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
    
    typealias ExampleCell = ExampleTable.Cell
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title = "Example"
        model = ExampleTable()
    }
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .subtitle
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.configureCell(cell, at: indexPath)
        
        guard
            let item = item(at: indexPath),
            let exampleCell = ExampleCell(rawValue: item.identifier)
        else {
            return
        }
        
        switch exampleCell {
        case .form:
            cell.action = { _ in
                self.pushTable(from: item, in: FormTVMC())
            }
        case .settings:
            cell.action = { _ in
                self.pushTable(from: item, in: SettingsTVMC())
            }
        case .github:
            cell.action = { _ in
                self.pushTable(from: item, in: GithubTVMC())
            }
        }
    }
    
}
