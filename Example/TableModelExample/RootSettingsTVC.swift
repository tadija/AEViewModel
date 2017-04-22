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
 
    enum CellID: String {
        case profile
        case airplane
        case wifi
        case bluetooth
        case cellular
        case hotspot
        case vpn
        case carrier
    }
    
    // MARK: - TableModelDelegate
    
    override func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        if let cellID = CellID(rawValue: identifier) {
            switch cellID {
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
        if let cellID = CellID(rawValue: item.identifier) {
            switch cellID {
            case .airplane, .vpn:
                if event == .valueChanged {
                    print("handleEvent with id: \(item.identifier)")
                }
            case .wifi:
                let tmvc = WiFiSettingsTVC(style: .grouped)
                pushSubmenu(with: item, in: tmvc)
            case .bluetooth, .cellular, .hotspot, .carrier:
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
