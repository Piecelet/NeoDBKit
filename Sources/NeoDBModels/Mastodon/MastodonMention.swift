//
//  MastodonMention.swift
//  NeoDB
//
//  Created by citron on 1/13/25.
//
//  From https://github.com/Dimillian/IceCubesApp
//  Witch is licensed under the AGPL-3.0 License
//

import Foundation

public struct MastodonMention: Codable, Identifiable, Hashable, Sendable, Equatable {
    public let id: String
    public let username: String
    public let url: URL
    public let acct: String
}
