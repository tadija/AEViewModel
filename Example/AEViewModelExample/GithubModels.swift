//
//  GithubModels.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

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
