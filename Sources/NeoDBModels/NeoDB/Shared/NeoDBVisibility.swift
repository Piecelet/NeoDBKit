//
//  NeoDBVisibility.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation
import SymbolKit

public enum NeoDBVisibility: Int, Codable, CaseIterable, Hashable, Equatable, Sendable {
    case pub = 0
    case followersOnly = 1
    case privateAndMentions = 2

    public var displayName: String {
        switch self {
        case .pub:
            return String(localized: "neodb.common.visibility.public.label", defaultValue: "Public", bundle: .module, comment: "NeoDB Visibility, for collections and marks - Label for public visibility option")
        case .followersOnly:
            return String(localized: "neodb.common.visibility.followers_only.label", defaultValue: "Followers Only", bundle: .module, comment: "NeoDB Visibility, for collections and marks - Label for unlisted visibility option")
        case .privateAndMentions:
            return String(localized: "neodb.common.visibility.private_and_mentions.label", defaultValue: "Private & Mentions", bundle: .module, comment: "NeoDB Visibility, for collections and marks - Label for private visibility option")
        }
    }

    public var displayDescription: String {
        switch self {
        case .pub:
            return String(localized: "neodb.common.visibility.public.description", defaultValue: "Visible to everyone.", bundle: .module, comment: "NeoDB Visibility - Description for public visibility option")
        case .followersOnly:
            return String(localized: "neodb.common.visibility.followers_only.description", defaultValue: "Visible to your followers.", bundle: .module, comment: "NeoDB Visibility - Description for unlisted visibility option")
        case .privateAndMentions:
            return String(localized: "neodb.common.visibility.private_and_mentions.description", defaultValue: "Visible only to you and people you mention.", bundle: .module, comment: "NeoDB Visibility - Description for private visibility option")
        }
    }
    
    public var symbolImage: Symbol {
        switch self {
        case .pub: return .systemSymbol("globe")
        case .followersOnly: return .systemSymbol("person.2")
        case .privateAndMentions: return .systemSymbol("lock")
        }
    }

    public var symbolImageFill: Symbol {
        switch self {
        case .pub: return .systemSymbol("globe")
        case .followersOnly: return .systemSymbol("person.2.fill")
        case .privateAndMentions: return .systemSymbol("lock.fill")
        }
    }
}
