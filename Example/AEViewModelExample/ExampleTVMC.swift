/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

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
    
    override func configureCell(_ cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath) {
        super.configureCell(cell, at: indexPath)

        cell.accessoryType = .disclosureIndicator

        let itm = item(at: indexPath)
        guard let exampleCell = ExampleCell(rawValue: itm.identifier) else {
            return
        }
        
        switch exampleCell {
        case .form:
            cell.action = { _ in
                self.pushTable(from: itm, in: FormTVMC())
            }
        case .settings:
            cell.action = { _ in
                self.pushTable(from: itm, in: SettingsTVMC())
            }
        case .github:
            cell.action = { _ in
                self.pushTable(from: itm, in: GithubTVMC())
            }
        }
    }
    
}
