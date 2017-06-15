//
//  SettingsTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/9/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import AEViewModel

final class SettingsTVMC: TableViewModelController {
    
    typealias SettingsItem = SettingsTable.ItemType
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: Override

    override func cell(forIdentifier identifier: String) -> TableCell {
        switch identifier {
        case SettingsItem.profile.rawValue:
            let nib = UINib(nibName: "CustomCellWithNib", bundle: nil)
            return .customNib(nib: nib)
        case SettingsItem.airplane.rawValue,
             SettingsItem.vpn.rawValue:
            return .toggle
        case SettingsItem.wifi.rawValue,
             SettingsItem.bluetooth.rawValue,
             SettingsItem.hotspot.rawValue,
             SettingsItem.carrier.rawValue:
            return .rightDetail
        default:
            return .basic
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
        
        switch item.identifier {
        case SettingsItem.airplane.rawValue,
             SettingsItem.vpn.rawValue:
            cell.action = { _ in
                print("handleEvent with id: \(item.identifier)")
            }
        case SettingsItem.wifi.rawValue:
            cell.action = { _ in
                let wifiSubmenu = WiFiSettingsTVMC(style: .grouped)
                self.pushTable(from: item, in: wifiSubmenu)
            }
        case SettingsItem.bluetooth.rawValue,
             SettingsItem.cellular.rawValue,
             SettingsItem.hotspot.rawValue,
             SettingsItem.carrier.rawValue:
            cell.action = { _ in
                let defaultSubmenu = TableViewModelController(style: .grouped)
                self.pushTable(from: item, in: defaultSubmenu)
            }
        default:
            break
        }
    }
    
}

// MARK: - WiFiSettingsTVC

class WiFiSettingsTVMC: TableViewModelController {
    
    typealias WifiItem = SettingsTable.Wifi.ItemType
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        switch identifier {
        case WifiItem.wifiSwitch.rawValue,
             WifiItem.joinNetworksSwitch.rawValue:
            return .toggle
        default:
            return .basic
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
        
        switch item.identifier {
        case WifiItem.wifiSwitch.rawValue,
             WifiItem.joinNetworksSwitch.rawValue:
            cell.action = { _ in
                print("handleEvent with id: \(item.identifier)")
            }
        case WifiItem.wifiNetwork.rawValue:
            cell.action = { _ in
                let tvc = TableViewModelController(style: .grouped)
                self.pushTable(from: item, in: tvc)
            }
        default:
            break
        }
    }
    
}
