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
    
    // MARK: - Types
    
    enum CellType: String {
        case wifiSwitch
        case wifiNetwork
        case joinNetworksSwitch
    }
    
    // MARK: - Override
    
    override func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        if let cellType = CellType(rawValue: identifier) {
            switch cellType {
            case .wifiSwitch:
                return .toggle
            case .wifiNetwork:
                return .default
            case .joinNetworksSwitch:
                return .toggle
            }
        } else {
            return .default
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableModelCell) {
        if let cellType = CellType(rawValue: item.identifier) {
            switch cellType {
            case .wifiSwitch, .joinNetworksSwitch:
                if event == .valueChanged {
                    print("handleEvent with id: \(item.identifier)")
                }
            case .wifiNetwork:
                let tmvc = TableModelViewController(style: .grouped)
                pushSubmenu(with: item, in: tmvc)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func pushSubmenu(with item: Item, in tmvc: TableModelViewController) {
        if let model = item.submodel {
            tmvc.model = model
            navigationController?.pushViewController(tmvc, animated: true)
        }
    }
    
}
