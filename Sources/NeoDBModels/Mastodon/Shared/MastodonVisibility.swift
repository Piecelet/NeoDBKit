//
//  MastodonVisibility.swift
//  NeoDBKit
//
//  Created by citron on 1/13/25.
//

import Foundation

public enum MastodonVisibility: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
    case pub = "public"
    case unlisted
    case priv = "private"
    case direct

    public var displayName: String {
        switch self {
        case .pub:
            return String(
                localized: "timelines_visibility_public",
                table: "Timelines"
            )
        case .unlisted:
            return String(
                localized: "timelines_visibility_unlisted",
                table: "Timelines"
            )
        case .priv:
            return String(
                localized: "timelines_visibility_private",
                table: "Timelines"
            )
        case .direct:
            return String(
                localized: "timelines_visibility_direct",
                table: "Timelines"
            )
        }
    }
}

