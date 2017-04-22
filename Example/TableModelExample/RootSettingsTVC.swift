//
//  RootSettingsTVC.swift
//  TableModelExample
//
//  Created by Marko Tadić on 4/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import TableModel

class RootSettingsTVC: TableModelViewController {
 
    // MARK: - Types
    
    enum CellType: String {
        case profile
        case airplane
        case wifi
        case bluetooth
        case cellular
        case hotspot
        case vpn
        case carrier
    }
    
    // MARK: - Override
    
    override func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        if let cellType = CellType(rawValue: identifier) {
            switch cellType {
            case .profile:
                return .subtitle
            case .airplane:
                return .toggle
            case .wifi:
                return .rightDetail
            case .bluetooth:
                return .rightDetail
            case .cellular:
                return .default
            case .hotspot:
                return .rightDetail
            case .vpn:
                return .toggle
            case .carrier:
                return .rightDetail
            }
        } else {
            return .default
        }
    }
    
    override func configureCell(_ cell: TableModelCell, with item: Item) {
        super.configureCell(cell, with: item)
        
        if let toggleCell = cell as? ToggleCell {
            toggleCell.toggle.onTintColor = UIColor.orange
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableModelCell) {
        if let cellType = CellType(rawValue: item.identifier) {
            switch cellType {
            case .airplane, .vpn:
                if event == .valueChanged {
                    print("handleEvent with id: \(item.identifier)")
                }
            case .wifi:
                let wifiSubmenu = WiFiSettingsTVC(style: .grouped)
                pushSubmenu(with: item, in: wifiSubmenu)
            case .bluetooth, .cellular, .hotspot, .carrier:
                let defaultSubmenu = TableModelViewController(style: .grouped)
                pushSubmenu(with: item, in: defaultSubmenu)
            default:
                break
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
