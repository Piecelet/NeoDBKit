//
//  ItemProtocol+Metadata.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension ItemProtocol {
    public var keyMetadata: [String] {
        var metadata: [String] = []
        
        switch self {
        case let book as EditionSchema:
            metadata = book.keyMetadata
        case let movie as MovieSchema:
            metadata = movie.keyMetadata
        case let tv as TVShowSchema:
            metadata = tv.keyMetadata
        case let music as AlbumSchema:
            metadata = music.keyMetadata
        case let performance as PerformanceSchema:
            metadata = performance.keyMetadata
        case let podcast as PodcastSchema:
            metadata = podcast.keyMetadata
        case let game as GameSchema:
            metadata = game.keyMetadata
        default:
            break
        }
        
        return metadata
    }
}
