//
//  ItemExternalResourceSchema+Known.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/3/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//


import Foundation
#if canImport(SymbolKit)
import SymbolKit
#endif

// MARK: - Identify Resource

public extension ItemExternalResourceSchema {
    // Public computed properties used across modules
    var type: ItemKnownExternalResource {
        let host = url.host?.lowercased() ?? ""
        let resource: ItemKnownExternalResource

        // Books
        if let targetHost = ItemKnownExternalResource.douban.host,
            host.contains(targetHost)
        {
            resource = .douban
        } else if let targetHost = ItemKnownExternalResource.goodreads.host,
            host.contains(targetHost)
        {
            resource = .goodreads
        } else if let targetHost = ItemKnownExternalResource.booksTW.host,
            host.contains(targetHost)
        {
            resource = .booksTW
        } else if let targetHost = ItemKnownExternalResource.googleBooks.host,
            host.contains(targetHost)
        {
            resource = .googleBooks
        }

        // Movies & TV
        else if let targetHost = ItemKnownExternalResource.imdb.host,
            host.contains(targetHost)
        {
            resource = .imdb
        } else if let targetHost = ItemKnownExternalResource.tmdb.host,
            host.contains(targetHost)
        {
            resource = .tmdb
        } else if let targetHost = ItemKnownExternalResource.bangumi.host,
            host.contains(targetHost)
        {
            resource = .bangumi
        }

        // Music
        else if let targetHost = ItemKnownExternalResource.bandcamp.host,
            host.contains(targetHost)
        {
            resource = .bandcamp
        } else if let targetHost = ItemKnownExternalResource.spotify.host,
            host.contains(targetHost)
        {
            resource = .spotify
        } else if let targetHost = ItemKnownExternalResource.appleMusic.host,
            host.contains(targetHost)
        {
            resource = .appleMusic
        } else if let targetHost = ItemKnownExternalResource.discogs.host,
            host.contains(targetHost)
        {
            resource = .discogs
        } else if let targetHost = ItemKnownExternalResource.applePodcasts.host,
            host.contains(targetHost)
        {
            resource = .applePodcasts
        }

        // Games
        else if let targetHost = ItemKnownExternalResource.igdb.host,
            host.contains(targetHost)
        {
            resource = .igdb
        } else if let targetHost = ItemKnownExternalResource.steam.host,
            host.contains(targetHost)
        {
            resource = .steam
        } else if let targetHost = ItemKnownExternalResource.bgg.host,
            host.contains(targetHost)
        {
            resource = .bgg
        }

        // Literature
        else if let targetHost = ItemKnownExternalResource.ao3.host,
            host.contains(targetHost)
        {
            resource = .ao3
        } else if let targetHost = ItemKnownExternalResource.jinjiang.host,
            host.contains(targetHost)
        {
            resource = .jinjiang
        } else if let targetHost = ItemKnownExternalResource.qidian.host,
            host.contains(targetHost)
        {
            resource = .qidian
        } else if let targetHost = ItemKnownExternalResource.ypshuo.host,
            host.contains(targetHost)
        {
            resource = .ypshuo
        }

        // Social & Others
        else if let targetHost = ItemKnownExternalResource.bilibili.host,
            host.contains(targetHost)
        {
            resource = .bilibili
        } else if let targetScheme = ItemKnownExternalResource.fedi.host,
            url.scheme == targetScheme
        {
            resource = .fedi
        } else if let targetScheme = ItemKnownExternalResource.rss.host,
            url.scheme == targetScheme
        {
            resource = .rss
        } else if let targetHost = ItemKnownExternalResource.metacritic.host,
            host.contains(targetHost)
        {
            resource = .metacritic
        }

        // Default to unknown if no match
        else {
            resource = .unknown
        }

        return resource
    }

    var name: String {
        return type.displayName ?? url.host
            ?? String(
                localized: "item.external_resource.unknown.label",
                defaultValue: "Unknown", table: "Item",
                comment: "Item External Resource Name - Unknown")
    }

    // Expose host string for UI (collides with URL.host, so keep as String)
    var host: String {
        return type.host ?? url.host ?? url.absoluteString
    }

    #if canImport(SymbolKit)
    // Public symbol image for UI (used by UIKit and SwiftUI call sites)
    var symbolImage: Symbol {
        // Prefer custom asset names where noted in comments; otherwise fallback to SF Symbols
        switch type {
        // Books
        case .douban: return .custom("custom.service.provider.douban")
        case .goodreads: return .custom("custom.service.provider.goodreads")
        case .booksTW: return .systemSymbol("book")
        case .googleBooks: return .custom("custom.service.provider.google")

        // Movies & TV
        case .imdb: return .custom("custom.service.provider.imdb")
        case .tmdb: return .systemSymbol("movieclapper")
        case .bangumi: return .systemSymbol("tv")

        // Music
        case .bandcamp: return .custom("custom.service.provider.bandcamp")
        case .spotify: return .custom("custom.service.provider.spotify")
        case .appleMusic: return .systemSymbol("music.note")
        case .appleBooks: return .systemSymbol("book")
        case .discogs: return .custom("custom.service.provider.discogs")
        case .applePodcasts: return .custom("custom.podcast")

        // Games
        case .igdb: return .systemSymbol("gamecontroller")
        case .steam: return .custom("custom.service.provider.steam")
        case .bgg: return .systemSymbol("die.face.5") // approximate dice icon

        // Literature
        case .ao3: return .custom("custom.service.provider.archiveofourown")
        case .jinjiang: return .systemSymbol("text.book.closed")
        case .qidian: return .systemSymbol("text.book.closed")
        case .ypshuo: return .systemSymbol("text.book.closed")

        // Social & Others
        case .bilibili: return .custom("custom.service.provider.bilibili")
        case .fedi: return .systemSymbol("network")
        case .rss: return .systemSymbol("dot.radiowaves.left.and.right")

        case .metacritic: return .custom("custom.service.provider.metacritic")

        case .unknown: return .systemSymbol("link")
        }
    }
    #endif
}
