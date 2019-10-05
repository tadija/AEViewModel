/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

final class CellsTVC: TableViewController {

    typealias Id = CellsDataSource.Id

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = CellsDataSource()
    }

    // MARK: Override

    override func cellType(forIdentifier identifier: String) -> TableCellType {
        guard let id = Id(rawValue: identifier) else {
            fatalError("Unsupported cell!")
        }
        switch id {
        case .basic:
            return .basic
        case .subtitle:
            return .subtitle
        case .leftDetail:
            return .leftDetail
        case .rightDetail:
            return .rightDetail
        case .toggle:
            return .toggle
        case .toggleWithSubtitle:
            return .toggleWithSubtitle
        case .slider:
            return .slider
        case .sliderWithLabels:
            return .sliderWithLabels
        case .textField:
            return .textField
        case .textView:
            return .textView
        case .button:
            return .button
        case .spinner:
            return .spinner
        }
    }

    override func action(for cell: TableCell, at indexPath: IndexPath, sender: Any) {
        guard let id = Id(rawValue: dataSource.identifier(at: indexPath)) else {
            fatalError("Unsupported cell!")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        print("Action for cell type: \(id.rawValue) [sender: \(sender)]")
    }

}
