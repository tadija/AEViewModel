//
//  TableDelegate.swift
//  TableModelExample
//
//  Created by Marko Tadić on 4/10/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import TableModel

class SettingsTableDelegate: TableModelDelegate {
    
    enum CellIdentifier: String {
        case profile
        case airplane
        case wifi
        case bluetooth
        case cellular
        case hotspot
        case vpn
        case carrier
    }
    
    func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        if let cellID = CellIdentifier(rawValue: identifier) {
            switch cellID {
            case .profile:
                return .subtitle
            case .airplane:
                return .toggle(delegate: self)
            case .wifi:
                return .rightDetail
            case .bluetooth:
                return .rightDetail
            case .cellular:
                return .default
            case .hotspot:
                return .rightDetail
            case .vpn:
                return .toggle(delegate: self)
            case .carrier:
                return .rightDetail
            }
        } else {
            return .default
        }
    }
    
}

extension SettingsTableDelegate: ToggleCellDelegate {
    
    func didChangeValue(sender: ToggleCell) {
        print("\(sender): toggle - \(sender.toggle.isOn)")
    }
    
}
