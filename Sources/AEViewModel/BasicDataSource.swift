/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - Model

public struct BasicDataSource: DataSource {
    public let title: String?
    public var sections: [Section]

    public init(title: String? = nil, sections: [Section] = [Section]()) {
        self.title = title
        self.sections = sections
    }

    public init(title: String? = nil, items: [Item]) {
        self.title = title
        self.sections = [BasicSection(items: items)]
    }

    public init(with data: Data, decoder: JSONDecoder = JSONDecoder()) throws {
        self = try decoder.decode(BasicDataSource.self, from: data)
    }
}

public struct BasicSection: Section {
    public let header: String?
    public let footer: String?
    public var items: [Item]

    public init(header: String? = nil, footer: String? = nil, items: [Item] = [Item]()) {
        self.header = header
        self.footer = footer
        self.items = items
    }
}

public struct BasicItem: Item {
    public let identifier: String
    public var viewModel: ViewModel
    public let child: DataSource?

    public init(identifier: String, viewModel: ViewModel = BasicViewModel(), child: DataSource? = nil) {
        self.identifier = identifier
        self.viewModel = viewModel
        self.child = child
    }

    public init(identifier: String,
                title: String? = nil, detail: String? = nil, image: String? = nil,
                child: DataSource? = nil) {
        self.identifier = identifier
        self.viewModel = BasicViewModel(title: title, detail: detail, image: image)
        self.child = child
    }
}

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

// MARK: - Codable

extension BasicDataSource: Codable {
    public enum CodingKeys: String, CodingKey {
        case title, sections
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        sections = try container.decode([BasicSection].self, forKey: .sections)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        if let sections = sections as? [BasicSection] {
            try container.encode(sections, forKey: .sections)
        }
    }
}

extension BasicSection: Codable {
    public enum CodingKeys: String, CodingKey {
        case header, footer, items
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        header = try container.decodeIfPresent(String.self, forKey: .header)
        footer = try container.decodeIfPresent(String.self, forKey: .footer)
        items = try container.decode([BasicItem].self, forKey: .items)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(header, forKey: .header)
        try container.encodeIfPresent(footer, forKey: .footer)
        if let items = items as? [BasicItem] {
            try container.encode(items, forKey: .items)
        }
    }
}

extension BasicItem: Codable {
    public enum CodingKeys: String, CodingKey {
        case identifier, viewModel, child
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        viewModel = try container.decode(BasicViewModel.self, forKey: .viewModel)
        child = try container.decodeIfPresent(BasicDataSource.self, forKey: .child)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encodeIfPresent(viewModel as? BasicViewModel, forKey: .viewModel)
        if let child = child as? BasicDataSource {
            try container.encodeIfPresent(child, forKey: .child)
        }
    }
}

extension BasicViewModel: Codable {
    public enum CodingKeys: String, CodingKey {
        case title, detail, image
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        detail = try container.decodeIfPresent(String.self, forKey: .detail)
        image = try container.decodeIfPresent(String.self, forKey: .image)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(detail, forKey: .detail)
        try container.encodeIfPresent(image, forKey: .image)
    }
}
