//
//  JoinMastodonServers.swift
//  NeoDB
//
//  Created by citron on 1/23/25.
//

import Foundation

public struct JoinMastodonServers: Decodable, Hashable, Identifiable, Sendable {
    public let domain: String
    public let version: String
    public let description: String
    public let languages: [String]
    public let region: Region
    public let categories: [Category]
    public let proxiedThumbnail: URL
    public let blurhash: String?
    public let totalUsers: Int
    public let lastWeekUsers: Int
    public let approvalRequired: Bool
    public let language: String
    public let category: Category

    public var id: String { domain }

    public enum Category: String, Codable, Sendable {
        case academia
        case activism
        case art
        case books
        case food
        case furry
        case games
        case general
        case hobby
        case journalism
        case lgbt
        case music
        case regional
        case religion
        case sports
        case tech
    }

    public enum Region: String, Codable, Sendable {
        case africa
        case asia
        case empty = ""
        case europe
        case northAmerica = "north_america"
        case oceania
        case southAmerica = "south_america"
    }
}
