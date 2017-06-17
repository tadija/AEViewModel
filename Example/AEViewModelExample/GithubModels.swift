//
//  GithubModels.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation
import Mappable

struct Repo: Mappable {
    let name: String
    let description: String?
    let url: String
    let updated: Date
    let forksCount: Int
    let starsCount: Int
    let owner: Owner
    
    init(map: [String : Any]) throws {
        name = try map.value(forKey: "name")
        description = try? map.value(forKey: "description")
        url = try map.value(forKey: "html_url")
        updated = Repo.parseDate(from: map["updated_at"])
        forksCount = try map.value(forKey: "forks_count")
        starsCount = try map.value(forKey: "stargazers_count")
        owner = try map.mappable(forKey: "owner")
    }
    
    private static let dateFormatter = DateFormatter()
    
    private static func parseDate(from value: Any?) -> Date {
        if let dateValue = value as? Date {
            return dateValue
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard
            let stringValue = value as? String,
            let date = dateFormatter.date(from: stringValue)
            else { return Date() }
        return date
    }
}

struct Owner: Mappable {
    let username: String
    let avatarURL: String
    
    init(map: [String : Any]) throws {
        username = try map.value(forKey: "login")
        avatarURL = try map.value(forKey: "avatar_url")
    }
}
