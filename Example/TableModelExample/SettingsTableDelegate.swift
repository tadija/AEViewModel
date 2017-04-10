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
    
    func cellStyle(forIdentifier identifier: String) -> TableModelCellStyle {
        switch identifier {
        case "airplaneMode":
            return .customClass(type: CustomCell.self)
        default:
            return .subtitle
        }
    }
    
}
