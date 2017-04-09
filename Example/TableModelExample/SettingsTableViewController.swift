//
//  Settings.swift
//  TableModelExample
//
//  Created by Marko Tadić on 4/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import TableModel

class SettingsTableViewController: TableViewController {
    
}

class TableModelDelegate: TableViewControllerDelegate {
    
    func cellType(forIdentifier identifier: String) -> UITableViewCell.Type? {
        switch identifier {
        case "airplaneMode":
            return CustomCell.self
        default:
//            return SubtitleCell.self
            return nil
        }
    }
    
}
