//
//  SettingsTVMC.swift
//  TableExample
//
//  Created by Marko Tadić on 6/9/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

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
    
    typealias id = MappableTable.SettingsItemType
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: Override

    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case id.profile.rawValue:
            let nib = UINib(nibName: "CustomCellWithNib", bundle: nil)
            return .customNib(nib: nib)
        case id.airplane.rawValue, id.vpn.rawValue:
            return .toggle
        case id.wifi.rawValue, id.bluetooth.rawValue, id.hotspot.rawValue, id.carrier.rawValue:
            return .rightDetail
        default:
            return .basic
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        switch item.identifier {
        case id.airplane.rawValue, id.vpn.rawValue:
            if event == .valueChanged {
                print("handleEvent with id: \(item.identifier)")
            }
        case id.wifi.rawValue:
            let wifiSubmenu = WiFiSettingsTVMC(style: .grouped)
            pushTable(from: item, in: wifiSubmenu)
            break
        case id.bluetooth.rawValue, id.cellular.rawValue, id.hotspot.rawValue, id.carrier.rawValue:
            let defaultSubmenu = TableViewModelController(style: .grouped)
            pushTable(from: item, in: defaultSubmenu)
        default:
            break
        }
    }
    
}

// MARK: - WiFiSettingsTVC

class WiFiSettingsTVMC: TableViewModelController {
    
    typealias id = MappableTable.WifiItemType
    
    // MARK: Override
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case id.wifiSwitch.rawValue, id.joinNetworksSwitch.rawValue:
            return .toggle
        default:
            return .basic
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        switch item.identifier {
        case id.wifiSwitch.rawValue, id.joinNetworksSwitch.rawValue:
            if event == .valueChanged {
                print("handleEvent with id: \(item.identifier)")
            }
        case id.wifiNetwork.rawValue:
            let tvc = TableViewModelController(style: .grouped)
            pushTable(from: item, in: tvc)
        default:
            break
        }
    }
    
}
