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

extension TableModel {
    
    static var settings: TableModel {
        var settings = TableModel("settings")
        settings.sections = [Section.user, Section.general]
        return settings
    }
    
}

extension Section {
    
    static var user: Section {
        var section = Section("profile")
        section.items = [Item.profile]
        return section
    }
    
    static var general: Section {
        var section = Section("general")
        section.items = [Item.airplane]
        return section
    }
    
}

extension Item {
    
    static var profile: Item {
        var item = Item("profile")
        item.imageName = "IconGray"
        item.title = "Marko Tadic"
        item.detail = "Apple ID, iCloud, iTunes & App Store"
        return item
    }
    
    static var airplane: Item {
        var item = Item("airplane")
        item.imageName = "IconOrange"
        item.title = "Airplane Mode"
        return item
    }
    
}
