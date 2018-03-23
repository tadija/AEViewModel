/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

final class ExampleTVMC: TableViewModelController {
    
    typealias Id = ExampleDataSource.Id
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Example"
        dataSource = ExampleDataSource()
    }
    
    // MARK: TableViewModelControllerDelegate
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        return .subtitle
    }
    
    override func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)

        cell.accessoryType = .disclosureIndicator
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: TableViewModelController) {
        switch dataSource.identifier(at: indexPath) {
        case Id.form:
            show(FormTVMC(), sender: self)
        case Id.settings:
            show(MainSettingsTVMC(), sender: self)
        case Id.github:
            show(GithubTVMC(), sender: self)
        default:
            break
        }
    }
    
}
