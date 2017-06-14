//
//  SettingsTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/9/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import AEViewModel

extension MappableTable {
    static var Settings: MappableTable {
        let url = Bundle.main.url(forResource: "settings", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let table = try! MappableTable(jsonData: data)
        return table
    }
    
    enum SettingsItemType: String {
        case profile
        case airplane
        case wifi
        case bluetooth
        case cellular
        case hotspot
        case vpn
        case carrier
    }
    
    enum WifiItemType: String {
        case wifiSwitch
        case wifiNetwork
        case joinNetworksSwitch
    }
}

final class SettingsTVMC: TableViewModelController {
    
    typealias SettingsItem = MappableTable.SettingsItemType
    
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
    
    override func configureCell(_ cell: TableViewModelCell, with item: Item) {
        super.configureCell(cell, with: item)
        
        switch item.identifier {
        case SettingsItem.airplane.rawValue,
             SettingsItem.vpn.rawValue:
            cell.action = {
                print("handleEvent with id: \(item.identifier)")
            }
        case SettingsItem.wifi.rawValue:
            cell.action = {
                let wifiSubmenu = WiFiSettingsTVMC(style: .grouped)
                self.pushTable(from: item, in: wifiSubmenu)
            }
        case SettingsItem.bluetooth.rawValue,
             SettingsItem.cellular.rawValue,
             SettingsItem.hotspot.rawValue,
             SettingsItem.carrier.rawValue:
            cell.action = {
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
    
    typealias WifiItem = MappableTable.WifiItemType
    
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
    
    override func configureCell(_ cell: TableViewModelCell, with item: Item) {
        super.configureCell(cell, with: item)
        
        switch item.identifier {
        case WifiItem.wifiSwitch.rawValue,
             WifiItem.joinNetworksSwitch.rawValue:
            cell.action = {
                print("handleEvent with id: \(item.identifier)")
            }
        case WifiItem.wifiNetwork.rawValue:
            cell.action = {
                let tvc = TableViewModelController(style: .grouped)
                self.pushTable(from: item, in: tvc)
            }
        default:
            break
        }
    }
    
}
