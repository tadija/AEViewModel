//
//  RootSettingsTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 4/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

class RootSettingsTVC: ViewController {
 
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
    
    override func cellStyle(forIdentifier identifier: String) -> Cell.Style {
        if let cellType = CellType(rawValue: identifier) {
            switch cellType {
            case .profile:
//                return .customClass(type: CustomCellWithCode.self)
                let nib = UINib(nibName: "CustomCellWithNib", bundle: nil)
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
    
    override func updateCell(_ cell: TableCell, with item: Item) {
        super.updateCell(cell, with: item)
        
        if let toggleCell = cell as? Cell.Toggle {
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
                let defaultSubmenu = ViewController(style: .grouped)
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
    
    private func pushSubmenu(with item: Item, in tmvc: ViewController) {
        if let table = item.table {
            tmvc.model = table
            navigationController?.pushViewController(tmvc, animated: true)
        }
    }
    
}
