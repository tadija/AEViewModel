/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import AEViewModel

struct SettingsDataSource: DataSource {
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

    var title: String?
    var sections: [Section]

    init() {
        do {
            let url = Bundle.main.url(forResource: "settings", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let viewModel = try BasicDataSource(with: data)
            title = viewModel.title
            sections = viewModel.sections
        } catch {
            debugPrint(error)
            fatalError("Failed to load settings.json.")
        }
    }
}
