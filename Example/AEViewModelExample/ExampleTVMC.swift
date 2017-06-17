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
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        model = ExampleTable()
    }
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .subtitle
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
        
        guard let type = ExampleItem(rawValue: item.identifier) else {
            return
        }
        switch type {
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
