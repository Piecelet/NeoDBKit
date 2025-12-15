//
//  ItemKnownExternalResource.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/3/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

// Exposed enum of known providers
public enum ItemKnownExternalResource: String {
    case douban = "Douban"
    case goodreads = "Goodreads"
    case booksTW = "BooksTW"
    case googleBooks = "Google Books"
    case imdb = "IMDb"
    case tmdb = "TMDB"
    case bangumi = "Bangumi"
    case bandcamp = "Bandcamp"
    case spotify = "Spotify"
    case appleMusic = "Apple Music"
    case discogs = "Discogs"
    case applePodcasts = "Apple Podcast"
    case appleBooks = "Apple Books"
    case igdb = "IGDB"
    case steam = "Steam"
    case bgg = "BGG"
    case ao3 = "AO3"
    case jinjiang = "JinJiang"
    case qidian = "Qidian"
    case ypshuo = "Ypshuo"
    case bilibili = "Bilibili"
    case fedi = "Fediverse"
    case rss = "RSS"
    case metacritic = "Metacritic"
    case unknown = "Unknown"

    // Public helpers for identification and presentation
    public var host: String? {
        switch self {
        case .douban: return "douban.com"
        case .goodreads: return "goodreads.com"
        case .booksTW: return "books.com.tw"
        case .googleBooks: return "books.google.com"
        case .imdb: return "imdb.com"
        case .tmdb: return "themoviedb.org"
        case .bangumi: return "bgm.tv"
        case .bandcamp: return "bandcamp.com"
        case .spotify: return "spotify.com"
        case .appleMusic: return "music.apple.com"
        case .discogs: return "discogs.com"
        case .applePodcasts: return "podcasts.apple.com"
        case .appleBooks: return "books.apple.com"
        case .igdb: return "igdb.com"
        case .steam: return "steampowered.com"
        case .bgg: return "boardgamegeek.com"
        case .ao3: return "archiveofourown.org"
        case .jinjiang: return "jjwxc.net"
        case .qidian: return "qidian.com"
        case .ypshuo: return "ypshuo.com"
        case .bilibili: return "bilibili.com"
        case .fedi: return "fedi.com"
        case .rss: return "rss.com"
        case .metacritic: return "metacritic.com"
        case .unknown: return nil
        }
    }

    public var scheme: String? {
        switch self {
        case .douban: return "douban://"
        case .goodreads: return "goodreads://"
        case .booksTW: return nil
        case .googleBooks: return "googlebooks://"
        case .imdb: return "imdb:///"
        case .tmdb: return nil
        case .bangumi: return "bangumi://"
        case .bandcamp: return "bandcamp://"
        case .spotify: return "spotify:"
        case .appleMusic: return "music://"
        case .discogs: return "record://"
        case .applePodcasts: return "podcasts://"
        case .appleBooks: return "ibooks://"
        case .igdb: return nil
        case .steam: return "steam://"
        case .bgg: return "boardgamegeek://"
        case .ao3: return nil
        case .jinjiang: return "jjwxc.net"
        case .qidian: return "qidian.com"
        case .ypshuo: return "ypshuo.com"
        case .bilibili: return "bilibili.com"
        case .fedi: return "fedi.com"
        case .rss: return "rss://"
        case .metacritic: return nil
        case .unknown: return nil
        }
    }

    public var displayName: String? {
        switch self {
        case .douban:
            return String(
                localized: "item.external_resource.known.douban.label", defaultValue: "Douban",
                table: "Item", comment: "Item External Resource Name - Douban")
        case .goodreads:
            return String(
                localized: "item.external_resource.known.goodreads.label",
                defaultValue: "Goodreads", table: "Item",
                comment: "Item External Resource Name - Goodreads")
        case .booksTW:
            return String(
                localized: "item.external_resource.known.bookstw.label",
                defaultValue: "BooksTW", table: "Item",
                comment: "Item External Resource Name - BooksTW")
        case .googleBooks:
            return String(
                localized: "item.external_resource.known.googlebooks.label",
                defaultValue: "Google Books", table: "Item",
                comment: "Item External Resource Name - Google Books")
        case .imdb:
            return String(
                localized: "item.external_resource.known.imdb.label", defaultValue: "IMDb",
                table: "Item", comment: "Item External Resource Name - IMDb")
        case .tmdb:
            return String(
                localized: "item.external_resource.known.tmdb.label", defaultValue: "TMDB",
                table: "Item", comment: "Item External Resource Name - TMDB")
        case .bangumi:
            return String(
                localized: "item.external_resource.known.bangumi.label",
                defaultValue: "Bangumi", table: "Item",
                comment: "Item External Resource Name - Bangumi")
        case .bandcamp:
            return String(
                localized: "item.external_resource.known.bandcamp.label", defaultValue: "Bandcamp", table: "Item",
                comment: "Item External Resource Name - Bandcamp")
        case .spotify:
            return String(
                localized: "item.external_resource.known.spotify.label",
                defaultValue: "Spotify", table: "Item",
                comment: "Item External Resource Name - Spotify")
        case .appleMusic:
            return String(
                localized: "item.external_resource.known.applemusic.label",
                defaultValue: "Apple Music", table: "Item",
                comment: "Item External Resource Name - Apple Music")
        case .appleBooks:
            return String(
                localized: "item.external_resource.known.applebooks.label",
                defaultValue: "Apple Books", table: "Item",
                comment: "Item External Resource Name - Apple Books")
        case .discogs:
            return String(
                localized: "item.external_resource.known.discogs.label",
                defaultValue: "Discogs", table: "Item",
                comment: "Item External Resource Name - Discogs")
        case .applePodcasts:
            return String(
                localized: "item.external_resource.known.applepodcasts.label",
                defaultValue: "Apple Podcasts", table: "Item",
                comment: "Item External Resource Name - Apple Podcasts")
        case .igdb:
            return String(
                localized: "item.external_resource.known.igdb.label", defaultValue: "IGDB",
                table: "Item", comment: "Item External Resource Name - IGDB")
        case .steam:
            return String(
                localized: "item.external_resource.known.steam.label",
                defaultValue: "Steam", table: "Item",
                comment: "Item External Resource Name - Steam")
        case .bgg:
            return String(
                localized: "item.external_resource.known.bgg.label",
                defaultValue: "Board Game Geek", table: "Item",
                comment: "Item External Resource Name - BGG")
        case .ao3:
            return String(
                localized: "item.external_resource.known.ao3.label", defaultValue: "AO3",
                table: "Item", comment: "Item External Resource Name - AO3")
        case .jinjiang:
            return String(
                localized: "item.external_resource.known.jinjiang.label",
                defaultValue: "JinJiang", table: "Item",
                comment: "Item External Resource Name - JinJiang")
        case .qidian:
            return String(
                localized: "item.external_resource.known.qidian.label", defaultValue: "Qidian",
                table: "Item", comment: "Item External Resource Name - Qidian")
        case .ypshuo:
            return String(
                localized: "item.external_resource.known.ypshuo.label",
                defaultValue: "Ypshuo", table: "Item",
                comment: "Item External Resource Name - Ypshuo")
        case .bilibili:
            return String(
                localized: "item.external_resource.known.bilibili.label",
                defaultValue: "Bilibili", table: "Item",
                comment: "Item External Resource Name - Bilibili")
        case .fedi:
            return String(
                localized: "item.external_resource.known.fedi.label",
                defaultValue: "Fediverse", table: "Item",
                comment: "Item External Resource Name - Fediverse")
        case .rss:
            return String(
                localized: "item.external_resource.known.rss.label", defaultValue: "RSS",
                table: "Item", comment: "Item External Resource Name - RSS")
        case .metacritic:
            return String(
                localized: "item.external_resource.known.metacritic.label",
                defaultValue: "Metacritic", table: "Item",
                comment: "Item External Resource Name - Metacritic")
        case .unknown: return nil
        }
    }
    
    public var colorSquareImageName: String {
        switch self {
        case .douban: return "provider.douban.square"
        case .goodreads: return "provider.goodreads.square"
        case .imdb: return "provider.imdb.square"
        case .metacritic: return "provider.metacritic.square"
        case .tmdb: return "provider.tmdb.square"
        case .appleBooks: return "provider.apple_books.square"
        case .appleMusic: return "provider.apple_music.square"
        case .applePodcasts: return "provider.apple_podcasts.square"
        case .spotify: return "provider.spotify.square"
        case .discogs: return "provider.discogs.square"
        case .igdb: return "provider.igdb.square"
        case .steam: return "provider.steam.square"
        case .bangumi: return "provider.bangumi.square"
        default: return ""
        }
    }
}
