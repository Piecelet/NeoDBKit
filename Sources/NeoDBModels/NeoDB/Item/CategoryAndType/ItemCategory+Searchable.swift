//
//  ItemCategory+Searchable.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension ItemCategory {
    public enum searchable: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
        case allItems = "all"
        case book
        case movie
        case tv
        case movieAndTV = "movie,tv"
        case music
        case game
        case podcast
        case performance

        public var itemCategory: ItemCategory? {
            switch self {
            case .book: return .book
            case .movie: return .movie
            case .tv: return .tv
            case .music: return .music
            case .game: return .game
            case .podcast: return .podcast
            case .performance: return .performance
            default: return nil
            }
        }

        public var displayName: String {
            switch self {
            case .allItems: return String(localized: "neodb.item.category.searchable.all.label", defaultValue: "All", bundle: .module, comment: "Item Category - Label for 'All' category in shelf")
            case .movieAndTV: return String(localized: "neodb.item.category.searchable.movie_and_tv.label", defaultValue: "Movie & TV", bundle: .module, comment: "Item Category - Label for 'Movies & TV Shows' category in shelf")
            default: return itemCategory?.displayNamePluralAbbreviated ?? self.rawValue
            }
        }

        // var symbolImage: Symbol {
        //     switch self {
        //     case .movieAndTv: return .systemSymbol(.film)
        //     case .allItems: return .systemSymbol(.squareGrid2x2)
        //     default: return self.itemCategory?.symbolImage ?? .systemSymbol(.squareGrid2x2)
        //     }
        // }

        // var symbolImageFill: Symbol {
        //     switch self {
        //     case .movieAndTv: return .systemSymbol(.filmFill)
        //     case .allItems: return .systemSymbol(.squareGrid2x2Fill)
        //     default: return self.itemCategory?.symbolImageFill ?? .systemSymbol(.squareGrid2x2Fill)
        //     }
        // }

        // var color: Color {
        //     switch self {
        //     case .allItems: return Color.accentColor
        //     default: return self.itemCategory?.color ?? .gray
        //     }
        // }
    }
}
