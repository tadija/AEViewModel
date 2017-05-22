//
//  WiFiSettingsTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 4/20/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

extension Cell.ID {
    static let wifiSwitch = "wifiSwitch"
    static let wifiNetwork = "wifiNetwork"
    static let joinNetworksSwitch = "joinNetworksSwitch"
}

class WiFiSettingsTVC: TableViewController {
    
    // MARK: - Override
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case id.wifiSwitch, id.joinNetworksSwitch:
            return .toggle
        default:
            return .basic
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableCell) {
        switch item.identifier {
        case id.wifiSwitch, id.joinNetworksSwitch:
            if event == .valueChanged {
                print("handleEvent with id: \(item.identifier)")
            }
        case id.wifiNetwork:
            let tvc = TableViewController(style: .grouped)
            pushSubmenu(with: item, in: tvc)
        default:
            break
        }
    }
    
    // MARK: - Helpers
    
    private func pushSubmenu(with item: Item, in tvc: TableViewController) {
        if let table = item.table {
            tvc.model = table
            navigationController?.pushViewController(tvc, animated: true)
        }
    }
    
}
