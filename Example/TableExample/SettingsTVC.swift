//
//  RootSettingsTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 4/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

extension Cell.ID {
    static let profile = "profile"
    static let airplane = "airplane"
    static let wifi = "wifi"
    static let bluetooth = "bluetooth"
    static let cellular = "cellular"
    static let hotspot = "hotspot"
    static let vpn = "vpn"
    static let carrier = "carrier"
}

class SettingsTVC: TableViewController {
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.table = SettingsTVC.fromJson
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: Override
    
    override func cellUI(forIdentifier identifier: String) -> Cell.UI {
        switch identifier {
        case id.profile:
//            return .customClass(type: CustomCellWithCode.self)
            let nib = UINib(nibName: "CustomCellWithNib", bundle: nil)
            return .customNib(nib: nib)
        case id.airplane, id.vpn:
            return .toggle
        case id.wifi, id.bluetooth, id.hotspot, id.carrier:
            return .rightDetail
        default:
            return .basic
        }
    }
    
    override func updateCell(_ cell: TableCell, with item: Item) {
        super.updateCell(cell, with: item)
        
        if let toggleCell = cell as? Cell.Toggle {
            toggleCell.toggle.onTintColor = UIColor.orange
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableCell) {
        switch item.identifier {
        case id.airplane, id.vpn:
            if event == .valueChanged {
                print("handleEvent with id: \(item.identifier)")
            }
        case id.wifi:
            let wifiSubmenu = WiFiSettingsTVC(style: .grouped)
            pushTable(from: item, in: wifiSubmenu)
        case id.bluetooth, id.cellular, id.hotspot, id.carrier:
            let defaultSubmenu = TableViewController(style: .grouped)
            pushTable(from: item, in: defaultSubmenu)
        default:
            break
        }
    }
    
    // MARK: Helpers
    
    static var fromJson: Table {
        guard
            let url = Bundle.main.url(forResource: "JsonModel", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let model = try? Table(jsonData: data)
        else {
            fatalError("Unable to load settings from settings-menu.json")
        }
        return model
    }
    
}

// MARK: - WiFiSettingsTVC

extension Cell.ID {
    static let wifiSwitch = "wifiSwitch"
    static let wifiNetwork = "wifiNetwork"
    static let joinNetworksSwitch = "joinNetworksSwitch"
}

class WiFiSettingsTVC: TableViewController {
    
    // MARK: Override
    
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
            pushTable(from: item, in: tvc)
        default:
            break
        }
    }
    
}
