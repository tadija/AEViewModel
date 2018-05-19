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
        dataSource = ExampleDataSource()
    }
    
    // MARK: Override
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        return .subtitle
    }
    
    override func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        cell.accessoryType = .disclosureIndicator
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: Any) {
        switch dataSource.identifier(at: indexPath) {
        case Id.cells:
            show(CellsTVMC(), sender: self)
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
