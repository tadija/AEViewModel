//
//  SettingsMenuModel.swift
//  TableModelExample
//
//  Created by Marko Tadić on 5/8/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation
import TableModel

extension TableModel {
    
    static func create() -> TableModel? {
        let model: TableModel?
        do {
            model = try TableModel(map: [
                // Model
                "id" : "settings",
                "title" : "Settings",
                
                // Sections
                "sections" : [
                    
                    // Profile
                    [
                        "id" : "profile",
                        "items" : [
                            [
                                "id": "profile",
                                "image": "IconGray",
                                "title": "Marko Tadic",
                                "detail": "Apple ID, iCloud, iTunes & App Store"
                            ]
                        ]
                    ],
                    
                    // General
                    [
                        "id" : "general",
                        "items" : [
                            [
                                "id": "airplane",
                                "image": "IconOrange",
                                "title": "Airplane Mode"
                            ]
                        ]
                    ]
                ]
            ])
        } catch {
            model = nil
            print(error)
        }
        return model
    }
    
}
