//
//  ExampleTVMC.swift
//  TableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

final class ExampleTMVC: TableViewModelController {
    override func customInit() {
        table = ExampleTable()
    }
}
