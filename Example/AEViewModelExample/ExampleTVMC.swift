/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

final class ExampleTVMC: TableViewModelController, TableViewModelControllerDelegate {
    
    typealias ExampleCell = ExampleTable.Cell
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title = "Example"
        delegate = self
        dataSource = ExampleTable()
    }
    
    // MARK: TableViewModelControllerDelegate
    
    func cell(forIdentifier identifier: String) -> TableCell {
        return .subtitle
    }
    
    func update(_ cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath) {
        let item = dataSource.item(at: indexPath)
        cell.update(with: item)

        cell.accessoryType = .disclosureIndicator

        guard let exampleCell = ExampleCell(rawValue: item.identifier) else {
            return
        }
        
        switch exampleCell {
        case .form:
            cell.action = { _ in
                /// - TODO: check later
//                self.pushTable(from: item, in: FormTVMC())
            }
        case .settings:
            cell.action = { _ in
                /// - TODO: check later
//                self.pushTable(from: item, in: SettingsTVMC())
            }
        case .github:
            cell.action = { _ in
                /// - TODO: check later
//                self.pushTable(from: item, in: GithubTVMC())
            }
        }
    }
    
}
