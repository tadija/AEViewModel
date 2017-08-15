//
//  SettingsTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/9/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import AEViewModel

class MappableTVMC: TableViewModelController {    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let mappableSection = model?.sections[section] as? MappableSection else {
            return nil
        }
        return mappableSection.header
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let mappableSection = model?.sections[section] as? MappableSection else {
            return nil
        }
        return mappableSection.footer
    }
}

final class SettingsTVMC: MappableTVMC {
    
    typealias SettingsCell = SettingsTable.Cell
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = (model as? MappableTable)?.title
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: Override

    override func cell(forIdentifier identifier: String) -> TableCell {        
        guard let settingsCell = SettingsCell(rawValue: identifier) else {
            return .basic
        }
        
        switch settingsCell {
        case .profile:
            return .customClass(type: SettingsProfileCell.self)
        case .airplane, .vpn:
            return .toggle
        case .wifi, .bluetooth, .hotspot, .carrier:
            return .rightDetail
        case .cellular:
            return .basic
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.configureCell(cell, at: indexPath)
        
        guard
            let item = model?.item(at: indexPath),
            let settingsCell = SettingsCell(rawValue: item.identifier)
        else {
            return
        }
        
        switch settingsCell {
        case .profile, .airplane, .vpn:
            cell.action = { _ in
                print("handleEvent with id: \(item.identifier)")
            }
        case .wifi:
            cell.action = { _ in
                let wifiSubmenu = WiFiSettingsTVMC(style: .grouped)
                wifiSubmenu.title = (item.child as? MappableTable)?.title
                self.pushTable(from: item, in: wifiSubmenu)
            }
        case .bluetooth, .cellular, .hotspot, .carrier:
            cell.action = { _ in
                let defaultSubmenu = MappableTVMC(style: .grouped)
                defaultSubmenu.title = (item.child as? MappableTable)?.title
                self.pushTable(from: item, in: defaultSubmenu)
            }
        }
    }
    
}

// MARK: - WiFiSettingsTVC

class WiFiSettingsTVMC: MappableTVMC {
    
    typealias WifiCell = SettingsTable.Wifi.Cell
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        guard let wifiCell = WifiCell(rawValue: identifier) else {
            return .basic
        }
        
        switch wifiCell {
        case .wifiSwitch, .joinNetworksSwitch:
            return .toggle
        case .wifiNetwork:
            return .basic
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.configureCell(cell, at: indexPath)
        
        guard
            let item = model?.item(at: indexPath),
            let wifiCell = WifiCell(rawValue: item.identifier)
        else {
            return
        }
        
        switch wifiCell {
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
