/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

final class CellsTVMC: TableViewModelController {

    typealias Id = CellsViewModel.Id

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CellsViewModel()
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
        case .textInput:
            return .textInput
        case .slider:
            return .slider
        case .sliderLabels:
            return .sliderLabels
        case .toggle:
            return .toggle
        case .toggleSubtitle:
            return .toggleSubtitle
        case .button:
            return .button
        }
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: Any) {
        guard let id = Id(rawValue: viewModel.identifier(at: indexPath)) else {
            fatalError("Unsupported cell!")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        print("Action for cell type: \(id.rawValue) [sender: \(sender)]")
    }

}
