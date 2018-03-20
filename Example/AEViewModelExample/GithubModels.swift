/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

struct Root: Codable {
    let items: [Repo]
}

struct Repo: Codable {
    let name: String
    let description: String?
    let url: String
    let updated: Date
    let forksCount: Int
    let starsCount: Int
    let owner: Owner

    private enum CodingKeys: String, CodingKey {
        case name, description, url = "html_url", updated = "updated_at",
        forksCount = "forks_count", starsCount = "stargazers_count", owner
    }
}

struct Owner: Codable {
    let username: String
    let avatarURL: String

    private enum CodingKeys: String, CodingKey {
        case username = "login", avatarURL = "avatar_url"
    }
}
