//
//  RootSettingsTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 4/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

class RootSettingsTVC: TableViewController {
 
    // MARK: - Types
    
    enum CellType: String {
        case profile
        case airplane
        case wifi
        case bluetooth
        case cellular
        case hotspot
        case vpn
        case carrier
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        loadModelFromJSON()
        loadModelFromCode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    // MARK: - Override
    
    override func cellStyle(forIdentifier identifier: String) -> TableCellStyle {
        if let cellType = CellType(rawValue: identifier) {
            switch cellType {
            case .profile:
//                return .customClass(type: CustomCellClass.self)
                let nib = UINib(nibName: "CustomCellNib", bundle: nil)
                return .customNib(nib: nib)
            case .airplane:
                return .toggle
            case .wifi:
                return .rightDetail
            case .bluetooth:
                return .rightDetail
            case .cellular:
                return .basic
            case .hotspot:
                return .rightDetail
            case .vpn:
                return .toggle
            case .carrier:
                return .rightDetail
            }
        } else {
            return .basic
        }
    }
    
    override func configureCell(_ cell: TableCell, with item: Item) {
        super.configureCell(cell, with: item)
        
        if let toggleCell = cell as? TableCellToggle {
            toggleCell.toggle.onTintColor = UIColor.orange
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableCell) {
        if let cellType = CellType(rawValue: item.identifier) {
            switch cellType {
            case .airplane, .vpn:
                if event == .valueChanged {
                    print("handleEvent with id: \(item.identifier)")
                }
            case .wifi:
                let wifiSubmenu = WiFiSettingsTVC(style: .grouped)
                pushSubmenu(with: item, in: wifiSubmenu)
            case .bluetooth, .cellular, .hotspot, .carrier:
                let defaultSubmenu = TableViewController(style: .grouped)
                pushSubmenu(with: item, in: defaultSubmenu)
            default:
                break
            }
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
    
    private func pushSubmenu(with item: Item, in tmvc: TableViewController) {
        if let model = item.submodel {
            tmvc.model = model
            navigationController?.pushViewController(tmvc, animated: true)
        }
    }
    
}
