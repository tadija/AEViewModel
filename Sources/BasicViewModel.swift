/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - Model

public struct BasicViewModel: ViewModel {
    public let title: String?
    public let detail: String?
    public let image: String?

    public init(title: String? = nil, detail: String? = nil, image: String? = nil) {
        self.title = title
        self.detail = detail
        self.image = image
    }
}

public struct BasicItem: Item {
    public let cellIdentifier: String
    public var viewModel: ViewModel

    public init(identifier: String, viewModel: ViewModel = BasicViewModel()) {
        self.cellIdentifier = identifier
        self.viewModel = viewModel
    }

    public init(identifier: String, title: String? = nil, detail: String? = nil, image: String? = nil) {
        self.cellIdentifier = identifier
        self.viewModel = BasicViewModel(title: title, detail: detail, image: image)
    }
}

public struct BasicSection: Section {
    public var items: [Item]

    public init(items: [Item] = [Item]()) {
        self.items = items
    }
}

public struct BasicDataSource: DataSource {
    public var sections: [Section]

    public init(sections: [Section] = [Section]()) {
        self.sections = sections
    }
}

// MARK: - Codable

extension BasicViewModel: Codable {
    public enum CodingKeys: String, CodingKey {
        case title, detail, image
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        detail = try container.decode(String.self, forKey: .detail)
        image = try container.decode(String.self, forKey: .image)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(detail, forKey: .detail)
        try container.encode(image, forKey: .image)
    }
}

extension BasicItem: Codable {
    public enum CodingKeys: String, CodingKey {
        case identifier, viewModel
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cellIdentifier = try container.decode(String.self, forKey: .identifier)
        viewModel = try container.decode(BasicViewModel.self, forKey: .viewModel)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cellIdentifier, forKey: .identifier)
        try container.encodeIfPresent(viewModel as? BasicViewModel, forKey: .viewModel)
    }
}

extension BasicSection: Codable {
    public enum CodingKeys: String, CodingKey {
        case items
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([BasicItem].self, forKey: .items)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
    }
}

extension BasicDataSource: Codable {
    public enum CodingKeys: String, CodingKey {
        case sections
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sections = try container.decode([BasicSection].self, forKey: .sections)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sections, forKey: .sections)
    }
}
