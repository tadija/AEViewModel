/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AEViewModel

class SettingsTVMC: TableViewModelController {
    override func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
        if let child = dataSource.item(at: indexPath).child, child.sections.count > 0 {
            cell.accessoryType = .disclosureIndicator
        }
    }
}

final class MainSettingsTVMC: SettingsTVMC {
    
    typealias Id = SettingsDataSource.Id
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = SettingsDataSource()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: Override

    override func cellType(forIdentifier identifier: String) -> TableCellType {
        switch identifier {
        case Id.profile:
            return .customClass(SettingsProfileCell.self)
        case Id.airplane, Id.vpn:
            return .toggle
        case Id.wifi, Id.bluetooth, Id.hotspot, Id.carrier:
            return .rightDetail
        case Id.cellular:
            return .basic
        default:
            fatalError("Identifier not supported.")
        }
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: Any) {
        let item = dataSource.item(at: indexPath)
        switch item.identifier {
        case Id.profile, Id.airplane, Id.vpn:
            print("handleEvent with id: \(item.identifier)")
        case Id.wifi:
            let ds = item.child ?? BasicDataSource()
            let vc = WiFiSettingsTVMC(dataSource: ds)
            show(vc, sender: self)
        case Id.bluetooth, Id.cellular, Id.hotspot, Id.carrier:
            let ds = item.child ?? BasicDataSource()
            let vc = SettingsTVMC(dataSource: ds)
            show(vc, sender: self)
        default:
            break
        }
    }
    
}

// MARK: - WiFiSettingsTVC

final class WiFiSettingsTVMC: SettingsTVMC {
    
    typealias Id = SettingsDataSource.Id.Wifi
    
    // MARK: Override
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        switch identifier {
        case Id.wifiSwitch, Id.joinNetworksSwitch:
            return .toggle
        case Id.wifiNetwork:
            return .basic
        default:
            fatalError("Identifier not supported.")
        }
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: Any) {
        let item = dataSource.item(at: indexPath)
        switch item.identifier {
        case Id.wifiSwitch,
             Id.joinNetworksSwitch:
            print("handleEvent with id: \(item.identifier)")
        case Id.wifiNetwork:
            print("join network with title: \((item.viewModel as? BasicViewModel)?.title ?? "n/a")")
        default:
            break
        }
    }
    
}
