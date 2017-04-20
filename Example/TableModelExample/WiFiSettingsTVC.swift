//
//  WiFiSettingsTVC.swift
//  TableModelExample
//
//  Created by Marko Tadić on 4/20/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import TableModel

class WiFiSettingsTVC: TableModelViewController {
    
    enum CellID: String {
        case wifiSwitch
        case wifiNetwork
        case joinNetworksSwitch
    }
    
    // MARK: - TableModelDelegate
    
    override func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        if let cellID = CellID(rawValue: identifier) {
            switch cellID {
            case .wifiSwitch:
                return .toggle(delegate: self)
            case .wifiNetwork:
                return .default
            case .joinNetworksSwitch:
                return .toggle(delegate: self)
            }
        } else {
            return .default
        }
    }
    
    override func handleAction(with item: Item, from cell: TableModelCell?) {
        if let cellID = CellID(rawValue: item.identifier) {
            switch cellID {
            case .wifiNetwork:
                let tmvc = TableModelViewController(style: .grouped)
                pushSubmenu(with: item, in: tmvc)
            default:
                break
            }
        }
    }
    
    private func pushSubmenu(with item: Item, in tmvc: TableModelViewController) {
        if let model = item.submodel {
            tmvc.model = model
            navigationController?.pushViewController(tmvc, animated: true)
        }
    }
    
}

extension WiFiSettingsTVC: ToggleCellDelegate {
    func didChangeValue(sender: ToggleCell) {
        print("\(sender): toggle - \(sender.toggle.isOn)")
    }
}
