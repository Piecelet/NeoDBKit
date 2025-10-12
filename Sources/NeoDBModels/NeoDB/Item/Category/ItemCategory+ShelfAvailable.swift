//
//  ItemCategory+ShelfAvailable.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

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

//        var symbolImage: Symbol {
//            switch self {
//            case .allItems: return .sfSymbol(.squareGrid2x2)
//            default: return self.itemCategory?.symbolImage ?? .systemSymbol(self.rawValue)
//            }
//        }

//        var symbolImageFill: Symbol {
//            switch self {
//            case .allItems: return .sfSymbol(.squareGrid2x2Fill)
//            default: return self.itemCategory?.symbolImageFill ?? .systemSymbol(self.rawValue)
//            }
//        }

        public var displayName: String {
            switch self {
            case .allItems: return String(localized: "neodb.item.category.shelf_available.all.label", defaultValue: "All", bundle: .module, comment: "Item Category - Label for 'All' category in shelf")
            default: return self.itemCategory?.displayNamePlural ?? self.rawValue
            }
        }

        // var color: Color {
        //     switch self {
        //     case .allItems: return Color.accentColor
        //     default: return self.itemCategory?.color ?? .gray
        //     }
        // }
    }
}
