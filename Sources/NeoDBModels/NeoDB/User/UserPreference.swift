//
//  UserPreference.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/8/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation
import SymbolKit

public struct UserPreference: Codable, Equatable, Hashable, Sendable {
    public let defaultCrosspost: Bool
    public let defaultVisibility: NeoDBVisibility
    public let hiddenCategories: [ItemCategory]
    public let language: ItemLocalizedText.KnownLanguage
}

public extension UserPreference {
    enum LocalizedField: String, CaseIterable, Hashable, Sendable {
        case defaultCrosspost
        case defaultVisibility
        case hiddenCategories
        case language

        public var displayName: String {
            switch self {
            case .defaultCrosspost:
                return String(
                    localized: "neodb.user.preference.default_crosspost.label",
                    defaultValue: "Auto-share",
                    bundle: .module,
                    comment: "User preference field name: whether to cross-post by default"
                )
            case .defaultVisibility:
                return String(
                    localized: "neodb.user.preference.default_visibility.label",
                    defaultValue: "Default visibility",
                    bundle: .module,
                    comment: "User preference field name: default visibility"
                )
            case .hiddenCategories:
                return String(
                    localized: "neodb.user.preference.hidden_categories.label",
                    defaultValue: "Hidden categories",
                    bundle: .module,
                    comment: "User preference field name: hidden item categories"
                )
            case .language:
                return String(
                    localized: "neodb.user.preference.language.label",
                    defaultValue: "Catalog language",
                    bundle: .module,
                    comment: "User preference field name: preferred language"
                )
            }
        }

        public var description: String {
            switch self {
            case .defaultCrosspost:
                return String(
                    localized: "neodb.user.preference.default_crosspost.description",
                    defaultValue: "Automatically share posts to your connected Mastodon, Bluesky, and other supported accounts.",
                    bundle: .module,
                    comment: "User preference field description: whether to cross-post by default"
                )
            case .defaultVisibility:
                return String(
                    localized: "neodb.user.preference.default_visibility.description",
                    defaultValue: "Set the default visibility for your posts.",
                    bundle: .module,
                    comment: "User preference field description: default visibility"
                )
            case .hiddenCategories:
                return String(
                    localized: "neodb.user.preference.hidden_categories.description",
                    defaultValue: "Manage which categories of items are hidden from your feed.",
                    bundle: .module,
                    comment: "User preference field description: hidden item categories"
                )
            case .language:
                return String(
                    localized: "neodb.user.preference.language.description",
                    defaultValue: "Choose your preferred language for catalogs.",
                    bundle: .module,
                    comment: "User preference field description: preferred language"
                )
            }
        }

        public func footer(_ instance: String) -> String {
            switch self {
            case .language, .defaultVisibility, .hiddenCategories:
                return ""
            case .defaultCrosspost:
                return String(
                    localized: "neodb.user.preference.default_crosspost.footer",
                    defaultValue: "You may change the instance setting on the \(instance) website.",
                    bundle: .module,
                    comment: "User preference field footer: preferred language with instance name"
                )
            }
        }

        public var symbol: Symbol{
            switch self {
            case .defaultCrosspost:
                return .custom("custom.paperplane.arrow.trianglehead.2.clockwise.rotate.90")
            case .defaultVisibility:
                return .systemSymbol("person.2")
            case .hiddenCategories:
                return .systemSymbol("slash.circle")
            case .language:
                return .systemSymbol("character.book.closed")
            }
        }

        public var symbolFill: Symbol {
            switch self {
            case .defaultCrosspost:
                return .custom("custom.paperplane.arrow.trianglehead.2.clockwise.rotate.90.fill")
            case .defaultVisibility:
                return .systemSymbol("person.2.fill")
            case .hiddenCategories:
                return .systemSymbol("slash.circle.fill")
            case .language:
                return .systemSymbol("character.book.closed.fill")
            }
        }

        public var symbolSlash: Symbol {
            switch self {
            case .defaultCrosspost:
                return .custom("custom.paperplane.arrow.trianglehead.2.clockwise.rotate.90.slash")
            case .defaultVisibility:
                return .systemSymbol("person.2.slash")
            case .hiddenCategories:
                return symbol
            case .language:
                return symbol
            }
        }

        public var symbolFillSlash: Symbol {
            switch self {
            case .defaultCrosspost:
                return .custom("custom.paperplane.arrow.trianglehead.2.clockwise.rotate.90.fill.slash")
            case .defaultVisibility:
                return .systemSymbol("person.2.fill.slash")
            case .hiddenCategories:
                return symbolFill
            case .language:
                return symbolFill
            }
        }
    }
}
