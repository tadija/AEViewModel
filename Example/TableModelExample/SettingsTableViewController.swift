//
//  Settings.swift
//  TableModelExample
//
//  Created by Marko Tadić on 4/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import TableModel

class SettingsTableViewController: TableModelViewController, TableModelDelegate {
    
    override func viewDidLoad() {
        modelDelegate = self
        super.viewDidLoad()
    }
 
    enum CellIdentifier: String {
        case profile
        case airplane
        case wifi
        case bluetooth
        case cellular
        case hotspot
        case vpn
        case carrier
    }
    
    func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        if let cellID = CellIdentifier(rawValue: identifier) {
            switch cellID {
            case .profile:
                return .subtitle
            case .airplane:
                return .toggle(delegate: self)
            case .wifi:
                return .rightDetail
            case .bluetooth:
                return .rightDetail
            case .cellular:
                return .default
            case .hotspot:
                return .rightDetail
            case .vpn:
                return .toggle(delegate: self)
            case .carrier:
                return .rightDetail
            }
        } else {
            return .default
        }
    }
    
    func handleAction(with item: Item, from cell: TableModelCell?) {
        if let cellID = CellIdentifier(rawValue: item.identifier) {
            switch cellID {
            case .wifi:
                if let model = item.submodel {
                    let tmvc = TableModelViewController(style: .grouped)
                    tmvc.model = model
                    tmvc.modelDelegate = modelDelegate
                    navigationController?.pushViewController(tmvc, animated: true)
                }
            default:
                break
            }
        }
    }
    
}

extension SettingsTableViewController: ToggleCellDelegate {
    func didChangeValue(sender: ToggleCell) {
        print("\(sender): toggle - \(sender.toggle.isOn)")
    }
}
