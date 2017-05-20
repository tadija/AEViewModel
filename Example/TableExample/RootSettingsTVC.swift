//
//  RootSettingsTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 4/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

extension ViewController.id {
    static let profile = "profile"
    static let airplane = "airplane"
    static let wifi = "wifi"
    static let bluetooth = "bluetooth"
    static let cellular = "cellular"
    static let hotspot = "hotspot"
    static let vpn = "vpn"
    static let carrier = "carrier"
}

class RootSettingsTVC: ViewController {
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadModelFromJSON()
//        loadModelFromCode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: - Override
    
    override func cellType(forIdentifier identifier: String) -> Cell.`Type` {
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
            pushSubmenu(with: item, in: wifiSubmenu)
        case id.bluetooth, id.cellular, id.hotspot, id.carrier:
            let defaultSubmenu = ViewController(style: .grouped)
            pushSubmenu(with: item, in: defaultSubmenu)
        default:
            break
        }
    }
    
    // MARK: - Helpers
    
    private func loadModelFromJSON() {
        guard
            let url = Bundle.main.url(forResource: "settings-menu", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let model = try? Table(jsonData: data)
        else {
            fatalError("Unable to load settings from settings-menu.json")
        }
        self.model = model
    }
    
    private func loadModelFromCode() {
        self.model = Table.settings
    }
    
    private func pushSubmenu(with item: Item, in tmvc: ViewController) {
        if let table = item.table {
            tmvc.model = table
            navigationController?.pushViewController(tmvc, animated: true)
        }
    }
    
}
