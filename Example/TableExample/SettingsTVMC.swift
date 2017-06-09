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
}

final class SettingsTVMC: TableViewModelController {
    
    typealias Settings = MappableTable.SettingsItemType
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: Override

    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case Settings.profile.rawValue:
            let nib = UINib(nibName: "CustomCellWithNib", bundle: nil)
            return .customNib(nib: nib)
        case Settings.airplane.rawValue, Settings.vpn.rawValue:
            return .toggle
        case Settings.wifi.rawValue, Settings.bluetooth.rawValue, Settings.hotspot.rawValue, Settings.carrier.rawValue:
            return .rightDetail
        default:
            return .basic
        }
    }
    
    override func updateCell(_ cell: TableViewModelCell, with item: Item) {
        super.updateCell(cell, with: item)
        
        if let toggleCell = cell as? Cell.Toggle {
            toggleCell.toggle.onTintColor = UIColor.orange
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        switch item.identifier {
        case Settings.airplane.rawValue, Settings.vpn.rawValue:
            if event == .valueChanged {
                print("handleEvent with id: \(item.identifier)")
            }
        case Settings.wifi.rawValue:
//            let wifiSubmenu = WiFiSettingsTVC(style: .grouped)
//            pushTable(from: item, in: wifiSubmenu)
            break
        case Settings.bluetooth.rawValue, Settings.cellular.rawValue, Settings.hotspot.rawValue, Settings.carrier.rawValue:
            let defaultSubmenu = TableViewModelController(style: .grouped)
            pushTable(from: item, in: defaultSubmenu)
        default:
            break
        }
    }
    
}
