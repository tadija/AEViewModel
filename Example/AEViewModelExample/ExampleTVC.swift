/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

final class ExampleTVC: TableViewController {
    
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
    
    override func update(_ cell: TableCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        cell.accessoryType = .disclosureIndicator
    }

    override func action(for cell: TableCell, at indexPath: IndexPath, sender: Any) {
        switch dataSource.identifier(at: indexPath) {
        case Id.cells:
            show(CellsTVC(), sender: self)
        case Id.form:
            show(FormTVC(), sender: self)
        case Id.settings:
            show(MainSettingsTVC(), sender: self)
        case Id.github:
            show(GithubTVC(), sender: self)
        default:
            break
        }
    }
    
}
