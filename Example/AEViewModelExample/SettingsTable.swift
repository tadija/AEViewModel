//
//  SettingsTable.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/15/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation

typealias SettingsTable = MappableTable.Settings

extension MappableTable {
    
    struct Settings {
        enum Cell: String {
            case profile
            case airplane
            case wifi
            case bluetooth
            case cellular
            case hotspot
            case vpn
            case carrier
        }
        
        static var fromJson: MappableTable {
            let url = Bundle.main.url(forResource: "settings", withExtension: "json")!
            let data = try! Data(contentsOf: url)
            let table = try! MappableTable(jsonData: data)
            return table
        }
        
        struct Wifi {
            enum Cell: String {
                case wifiSwitch
                case wifiNetwork
                case joinNetworksSwitch
            }
        }
    }
    
}
