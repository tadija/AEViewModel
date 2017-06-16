//
//  GithubTable.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel

struct GithubTable: Table {
    
    // MARK: Types
    
    enum ItemType: String {
        case repo
    }
    
    // MARK: Table
    
    let title = "Github"
    var sections = [Section]()
    
}
