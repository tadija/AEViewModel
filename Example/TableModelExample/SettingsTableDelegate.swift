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
    }
    
    func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        if let cellID = CellIdentifier(rawValue: identifier) {
            switch cellID {
            case .profile:
                return .subtitle
            case .airplane:
                return .rightSwitch
            case .wifi:
                return .rightDetail
            case .bluetooth:
                return .rightDetail
            case .cellular:
                return .default
            }
        } else {
            return .default
        }
    }
    
}
