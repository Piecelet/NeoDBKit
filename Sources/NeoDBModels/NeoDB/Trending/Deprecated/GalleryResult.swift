//
//  GalleryItems.swift
//  NeoDBKit
//
//  Created by citron on 1/15/25.
//

import Foundation

@available(*, deprecated, message: "Use trending from TrendingEndpoint with TrendingItemResult instead.")
public struct GalleryResult: Codable, Identifiable {
    public let name: String
    public let items: TrendingItemResult
    
    public var id: String { name }

    // Explicit initializer to avoid ambiguity with Codable's init(from:)
    public init(name: String, items: TrendingItemResult) {
        self.name = name
        self.items = items
    }

    public var itemCategory: ItemCategory.galleryCategory? {
        switch name {
        case "trending_book":
            return .book
        case "trending_movie":
            return .movie
        case "trending_tv":
            return .tv
        case "trending_game":
            return .game
        case "trending_music":
            return .music
        case "trending_podcast":
            return .podcast
        default: 
            return nil
        }
    }

    public var displayTitle: String { itemCategory?.displayName ?? name }
}
