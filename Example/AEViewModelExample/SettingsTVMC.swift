/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

class SettingsTVMC: TableViewModelController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = (dataSource as? SettingsTable)?.title
    }
    override func update(_ cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
        guard
            let item = dataSource.item(at: indexPath) as? SettingsItem,
            let vm = item.viewModel as? SettingsViewModel,
            let child = vm.submodel, child.sections.count > 0
        else {
            return
        }
        cell.accessoryType = .disclosureIndicator
    }
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (dataSource.sections[section] as? SettingsSection)?.header
    }
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return (dataSource.sections[section] as? SettingsSection)?.footer
    }
}

final class MainSettingsTVMC: SettingsTVMC {
    
    typealias SettingsCell = SettingsTable.Cell
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: TableViewModelControllerDelegate

    override func cell(forIdentifier identifier: String) -> TableCell {
        guard let settingsCell = SettingsCell(rawValue: identifier) else {
            return .basic
        }
        switch settingsCell {
        case .profile:
            return .customClass(type: SettingsProfileCell.self)
        case .airplane, .vpn:
            return .toggleBasic
        case .wifi, .bluetooth, .hotspot, .carrier:
            return .rightDetail
        case .cellular:
            return .basic
        }
    }

    override func performAction(for cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath, sender: TableViewModelController) {
        let item = dataSource.item(at: indexPath)
        guard let settingsCell = SettingsCell(rawValue: item.identifier) else {
            return
        }
        switch settingsCell {
        case .profile, .airplane, .vpn:
            print("handleEvent with id: \(item.identifier)")
        case .wifi:
            let dataSource: DataSource = (item.viewModel as? SettingsViewModel)?.submodel ?? BasicDataSource()
            let vc = WiFiSettingsTVMC(dataSource: dataSource)
            show(vc, sender: self)
        case .bluetooth, .cellular, .hotspot, .carrier:
            let dataSource: DataSource = (item.viewModel as? SettingsViewModel)?.submodel ?? BasicDataSource()
            let vc = SettingsTVMC(dataSource: dataSource)
            show(vc, sender: self)
        }
    }
    
}

// MARK: - WiFiSettingsTVC

class WiFiSettingsTVMC: SettingsTVMC {
    
    typealias WifiCell = SettingsTable.Wifi.Cell
    
    // MARK: TableViewModelControllerDelegate
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        guard let wifiCell = WifiCell(rawValue: identifier) else {
            return .basic
        }
        switch wifiCell {
        case .wifiSwitch, .joinNetworksSwitch:
            return .toggleBasic
        case .wifiNetwork:
            return .basic
        }
    }

    override func performAction(for cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath, sender: TableViewModelController) {
        let item = dataSource.item(at: indexPath)
        guard let wifiCell = WifiCell(rawValue: item.identifier) else {
            return
        }
        switch wifiCell {
        case .wifiSwitch,
             .joinNetworksSwitch:
            print("handleEvent with id: \(item.identifier)")
        case .wifiNetwork:
            print("join network with title: \(String(describing: item.viewModel.title))")
        }
    }
    
}
