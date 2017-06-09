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
}

final class SettingsTVMC: TableViewModelController {
    
}
