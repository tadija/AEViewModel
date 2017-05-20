//
//  WiFiSettingsTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 4/20/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

extension ViewController.id {
    static let wifiSwitch = "wifiSwitch"
    static let wifiNetwork = "wifiNetwork"
    static let joinNetworksSwitch = "joinNetworksSwitch"
}

class WiFiSettingsTVC: ViewController {
    
    // MARK: - Override
    
    override func cellType(forIdentifier identifier: String) -> Cell.`Type` {
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
            let tmvc = ViewController(style: .grouped)
            pushSubmenu(with: item, in: tmvc)
        default:
            break
        }
    }
    
    // MARK: - Helpers
    
    private func pushSubmenu(with item: Item, in tmvc: ViewController) {
        if let table = item.table {
            tmvc.model = table
            navigationController?.pushViewController(tmvc, animated: true)
        }
    }
    
}
