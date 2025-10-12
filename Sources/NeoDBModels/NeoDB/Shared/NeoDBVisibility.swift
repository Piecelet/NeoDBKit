//
//  NeoDBVisibility.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public enum NeoDBVisibility: Int, Codable, CaseIterable, Hashable, Equatable, Sendable {
    case pub = 0
    case followersOnly = 1
    case priv = 2

    var displayName: String {
        switch self {
        case .pub:
            return String(localized: "neodb.common.visibility.public.label", defaultValue: "Public", bundle: .module, comment: "NeoDB Visibility, for collections and marks - Label for public visibility option")
        case .followersOnly:
            return String(localized: "neodb.common.visibility.followers_only.label", defaultValue: "Followers Only", bundle: .module, comment: "NeoDB Visibility, for collections and marks - Label for unlisted visibility option")
        case .priv:
            return String(localized: "neodb.common.visibility.private.label", defaultValue: "Private", bundle: .module, comment: "NeoDB Visibility, for collections and marks - Label for private visibility option")
        }
    }

    var displayDescription: String {
        switch self {
        case .pub:
            return String(localized: "neodb.common.visibility.public.description", defaultValue: "Everyone can see it.", bundle: .module, comment: "NeoDB Visibility - Description for public visibility option")
        case .followersOnly:
            return String(localized: "neodb.common.visibility.followers_only.description", defaultValue: "Only your followers can see it.", bundle: .module, comment: "NeoDB Visibility - Description for unlisted visibility option")
        case .priv:
            return String(localized: "neodb.common.visibility.private.description", defaultValue: "Only you can see it.", bundle: .module, comment: "NeoDB Visibility - Description for private visibility option")
        }
    }
}
