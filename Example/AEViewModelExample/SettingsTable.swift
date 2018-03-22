/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

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

        static var codable: SettingsDataSource {
            do {
                let url = Bundle.main.url(forResource: "settings", withExtension: "json")!
                let data = try Data(contentsOf: url)
                let table = try JSONDecoder().decode(SettingsDataSource.self, from: data)
                return table
            } catch {
                print(error)
                fatalError()
            }
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
