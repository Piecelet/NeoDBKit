//
//  ItemCategory+ShelfAvailable.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation
#if canImport(SymbolKit)
import SymbolKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif

extension ItemCategory {
    public enum shelfAvailable: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
        case allItems
        case book
        case movie
        case tv
        case music
        case game
        case podcast
        case performance

        public var itemCategory: ItemCategory? {
            switch self {
            case .allItems: return nil
            case .book: return .book
            case .movie: return .movie
            case .tv: return .tv
            case .music: return .music
            case .game: return .game
            case .podcast: return .podcast
            case .performance: return .performance
            }
        }

        public var displayName: String {
            switch self {
            case .allItems: return String(localized: "neodb.item.category.shelf_available.all.label", defaultValue: "All", bundle: .module, comment: "Item Category - Label for 'All' category in shelf")
            default: return self.itemCategory?.displayNamePlural ?? self.rawValue
            }
        }
    }
}


#if canImport(SymbolKit)
extension ItemCategory.shelfAvailable {

        public var symbolImage: Symbol {
            switch self {
            case .allItems: return .systemSymbol("square.grid.2x2")
            default: return self.itemCategory?.symbolImage ?? .systemSymbol(self.rawValue)
            }
        }

        public var symbolImageFill: Symbol {
            switch self {
            case .allItems: return .systemSymbol("square.grid.2x2.fill")
            default: return self.itemCategory?.symbolImageFill ?? .systemSymbol(self.rawValue)
            }
        }
}
#endif

#if canImport(SwiftUI)
extension ItemCategory.shelfAvailable {
        public var color: Color {
            switch self {
            case .allItems: return Color.accentColor
            default: return self.itemCategory?.color ?? .gray
            }
        }
}
#endif