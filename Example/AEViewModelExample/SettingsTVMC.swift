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
        guard let type = SettingsItem(rawValue: identifier) else {
            return .basic
        }
        switch type {
        case .profile:
            let nib = UINib(nibName: "CustomCellWithNib", bundle: nil)
            return .customNib(nib: nib)
        case .airplane, .vpn:
            return .toggle
        case .wifi, .bluetooth, .hotspot, .carrier:
            return .rightDetail
        case .cellular:
            return .basic
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
        
        guard let type = SettingsItem(rawValue: item.identifier) else {
            return
        }
        switch type {
        case .profile, .airplane, .vpn:
            cell.action = { _ in
                print("handleEvent with id: \(item.identifier)")
            }
        case .wifi:
            cell.action = { _ in
                let wifiSubmenu = WiFiSettingsTVMC(style: .grouped)
                self.pushTable(from: item, in: wifiSubmenu)
            }
        case .bluetooth, .cellular, .hotspot, .carrier:
            cell.action = { _ in
                let defaultSubmenu = TableViewModelController(style: .grouped)
                self.pushTable(from: item, in: defaultSubmenu)
            }
        }
    }
    
}

// MARK: - WiFiSettingsTVC

class WiFiSettingsTVMC: TableViewModelController {
    
    typealias WifiItem = SettingsTable.Wifi.ItemType
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        guard let type = WifiItem(rawValue: identifier) else {
            return .basic
        }
        switch type {
        case .wifiSwitch, .joinNetworksSwitch:
            return .toggle
        case .wifiNetwork:
            return .basic
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
        
        guard let type = WifiItem(rawValue: item.identifier) else {
            return
        }
        switch type {
        case .wifiSwitch,
             .joinNetworksSwitch:
            cell.action = { _ in
                print("handleEvent with id: \(item.identifier)")
            }
        case .wifiNetwork:
            cell.action = { _ in
                let tvc = TableViewModelController(style: .grouped)
                self.pushTable(from: item, in: tvc)
            }
        }
    }
    
}
