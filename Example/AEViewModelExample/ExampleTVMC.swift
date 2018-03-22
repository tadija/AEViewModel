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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Example"
        dataSource = ExampleTable()
    }
    
    // MARK: TableViewModelControllerDelegate
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .subtitle
    }
    
    override func update(_ cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        cell.accessoryType = .disclosureIndicator
    }

    override func performAction(for cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath, sender: TableViewModelController) {
        guard let cellType = ExampleCell(rawValue: dataSource.identifier(at: indexPath)) else {
            return
        }
        let vc: UIViewController
        switch cellType {
        case .form:
            vc = FormTVMC(dataSource: FormTable())
        case .settings:
            vc = SettingsTVMC(dataSource: SettingsTable.fromJson)
        case .github:
            vc = GithubTVMC()
        }
        show(vc, sender: self)
    }
    
}
