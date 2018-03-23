/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct SettingsDataSource: DataSource, Codable {
    struct Id {
        static let profile = "profile"
        static let airplane = "airplane"
        static let wifi = "wifi"
        static let bluetooth = "bluetooth"
        static let cellular = "cellular"
        static let hotspot = "hotspot"
        static let vpn = "vpn"
        static let carrier = "carrier"
        
        struct Wifi {
            static let wifiSwitch = "wifiSwitch"
            static let wifiNetwork = "wifiNetwork"
            static let joinNetworksSwitch = "joinNetworksSwitch"
        }
    }
    
    let title: String?
    var sections: [Section]
    
    init() {
        do {
            let url = Bundle.main.url(forResource: "settings", withExtension: "json")!
            let data = try Data(contentsOf: url)
            self = try JSONDecoder().decode(SettingsDataSource.self, from: data)
        } catch {
            debugPrint(error)
            fatalError("Failed to load SettingsDataSource from settings.json.")
        }
    }
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case title, sections
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        sections = try container.decode([BasicSection].self, forKey: .sections)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(sections, forKey: .sections)
    }
}
