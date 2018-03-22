/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

typealias SettingsTable = SettingsDataSource

extension SettingsTable {
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
    
    init() {
        do {
            let url = Bundle.main.url(forResource: "settings", withExtension: "json")!
            let data = try Data(contentsOf: url)
            self = try JSONDecoder().decode(SettingsDataSource.self, from: data)
        } catch {
            fatalError(error.localizedDescription)
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

struct SettingsViewModel: ViewModel, Codable {
    let title: String?
    let detail: String?
    let image: String?
    var submodel: SettingsDataSource?
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case title, detail, image, table, custom
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        detail = try container.decodeIfPresent(String.self, forKey: .detail)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        submodel = try container.decodeIfPresent(SettingsDataSource.self, forKey: .table)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(detail, forKey: .detail)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(submodel, forKey: .table)
    }
}
struct SettingsItem: Item, Codable {
    let identifier: String
    var viewModel: ViewModel?
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case id, data
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .id)
        viewModel = try container.decode(SettingsViewModel.self, forKey: .data)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .id)
        try container.encode(viewModel, forKey: .data)
    }
}
struct SettingsSection: Section, Codable {
    var header: String?
    var footer: String?
    var items: [Item]
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case header, footer, items
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        header = try container.decodeIfPresent(String.self, forKey: .header)
        footer = try container.decodeIfPresent(String.self, forKey: .footer)
        items = try container.decode([SettingsItem].self, forKey: .items)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(header, forKey: .header)
        try container.encodeIfPresent(footer, forKey: .footer)
        try container.encode(items, forKey: .items)
    }
}
struct SettingsDataSource: DataSource, Codable {
    var title: String
    var sections: [Section]
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case title, sections
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        sections = try container.decode([SettingsSection].self, forKey: .sections)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(sections, forKey: .sections)
    }
}
