//
//  ItemTVShowSchema.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

fileprivate let metadataArraySeparator = " "

// MARK: - TV Show Schema
public struct ItemTVShowSchema: ItemProtocol {
    public let id: ItemID
    public let uuid: ItemUUID
    public let url: ItemURL
    public let apiUrl: ItemApiURL
    public let type: ItemType
    public let category: ItemCategory
    public var parentUuid: ItemUUID? = nil
    public var displayTitle: String? = nil
    public var externalResources: [ItemExternalResourceSchema]? = nil
    public var title: String? = nil
    public var description: String? = nil
    public var localizedTitle: [ItemLocalizedText]? = nil
    public var localizedDescription: [ItemLocalizedText]? = nil
    public var coverImageUrl: URL? = nil
    public var rating: Double? = nil
    public var ratingCount: Int? = nil
    public var ratingDistribution: [Int]? = nil
    public var tags: [String]? = nil
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public var brief: String? = nil

    // Additional properties specific to TV Show
    public var seasonCount: Int? = nil
    public var origTitle: String? = nil
    @available(*, deprecated, message: "otherTitle is deprecated since NeoDB is no longer have it.")
    public var otherTitle: [String]? = nil
    public var director: [String]? = nil
    public var playwright: [String]? = nil
    public var actor: [String]? = nil
    public var genre: [String]? = nil
    public var language: [ItemLocalizedText.KnownLanguage]? = nil
    public var area: [String]? = nil {
        didSet {
            guard let a = area else { return }
            let sanitized = Self.sanitizeAreaValues(a)
            if sanitized != a {
                area = sanitized
            }
        }
    }
    public var year: Int? = nil
    public var site: String? = nil
    public var episodeCount: Int? = nil
    public var imdb: String? = nil

    // TV Show Schema
    public var seasonUuids: [ItemUUID]? = nil

    // TV Season Schema
    public var seasonNumber: Int? = nil
    public var episodeUuids: [ItemUUID]? = nil

    // TV Episode Schema
    public var episodeNumber: Int? = nil
}

extension TVShowSchema {
    public enum LocalizableMetadata {
        case title
        case description
        case type
        case category

        // Additional properties specific to TV Show
        case director
        case playwright
        case actor
        case genre
        case language
        case area
        case year
        case imdb
        case episodeCount
        case episodeCountFormatted(count: Int)
        case seasonCount
        case seasonCountFormatted(count: Int)

        // TV Season Schema
        case seasonNumber
        case seasonNumberFormatted(season: Int)

        // TV Episode Schema
        case episodeNumber
        case episodeNumberFormatted(episode: Int)

        public var displayName: String {
            switch self {
            case .title:
                return ItemSchema.LocalizableMetadata.title.displayName
            case .description:
                return ItemSchema.LocalizableMetadata.description.displayName
            case .type:
                return ItemSchema.LocalizableMetadata.type.displayName
            case .category:
                return ItemSchema.LocalizableMetadata.category.displayName
            case .director:
                return String(localized: "neodb.item.schema.tvshow.metadata.director.label", defaultValue: "Director", bundle: .module, comment: "TV Show Director label")
            case .playwright:
                return String(localized: "neodb.item.schema.tvshow.metadata.playwright.label", defaultValue: "Playwright", bundle: .module, comment: "TV Show Playwright label")
            case .actor:
                return String(localized: "neodb.item.schema.tvshow.metadata.actor.label", defaultValue: "Actor", bundle: .module, comment: "TV Show Actor label")
            case .genre:
                return String(localized: "neodb.item.schema.tvshow.metadata.genre.label", defaultValue: "Genre", bundle: .module, comment: "TV Show Genre label")
            case .language:
                return String(localized: "neodb.item.schema.tvshow.metadata.language.label", defaultValue: "Language", bundle: .module, comment: "TV Show Language label")
            case .area:
                return String(localized: "neodb.item.schema.tvshow.metadata.area.label", defaultValue: "Area", bundle: .module, comment: "TV Show Area label")
            case .year:
                return String(localized: "neodb.item.schema.tvshow.metadata.year.label", defaultValue: "Year", bundle: .module, comment: "TV Show Year label")
            case .imdb:
                return String(localized: "neodb.item.schema.tvshow.metadata.imdb.label", defaultValue: "IMDB", bundle: .module, comment: "TV Show IMDB label")
            case .episodeCount:
                return String(localized: "neodb.item.schema.tvshow.metadata.episode_count.label", defaultValue: "Number of Episodes", bundle: .module, comment: "TV Show Episode Count label")
            case .episodeCountFormatted(let count):
                return String(localized: "neodb.item.schema.tvshow.metadata.episode_count.formatted", defaultValue: "\(count) Episodes", bundle: .module, comment: "TV Show Episode Count formatted label")
            case .seasonCount:
                return String(localized: "neodb.item.schema.tvshow.metadata.season_count.label", defaultValue: "Season", bundle: .module, comment: "TV Show Season Count label")
            case .seasonCountFormatted(let count):
                return String(localized: "neodb.item.schema.tvshow.metadata.season_count.formatted", defaultValue: "\(count) Seasons", bundle: .module, comment: "TV Show Season Count formatted label")
            case .seasonNumber:
                return String(localized: "neodb.item.schema.tvshow_season.metadata.season_number.label", defaultValue: "Number of Seasons", bundle: .module, comment: "TV Show Season Number label")
            case .seasonNumberFormatted(let season):
                return String(localized: "neodb.item.schema.tvshow_season.metadata.season_number.formatted", defaultValue: "Season \(season)", bundle: .module, comment: "TV Show Season Number formatted label")
            case .episodeNumber:
                return String(localized: "neodb.item.schema.tvshow_episode.metadata.episode_number.label", defaultValue: "Episode", bundle: .module, comment: "TV Show Episode Number label")
            case .episodeNumberFormatted(let episode):
                return String(localized: "neodb.item.schema.tvshow_episode.metadata.episode_number.formatted", defaultValue: "Episode \(episode)", bundle: .module, comment: "TV Show Episode Number formatted label")
            }
        }
    }
}

extension TVShowSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if let area = area, !area.isEmpty {
            metadata.append(area.joined(separator: metadataArraySeparator))
        }
        if let genre = genre, !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        if let language = language, !language.isEmpty {
            let languageDisplayNames = language.compactMap { $0.displayNameCodeAndNameAbbreviatedInChineseWithoutUnknown }
            if !languageDisplayNames.isEmpty {
                metadata.append(languageDisplayNames.joined(separator: metadataArraySeparator))
            }
        }
        if let director = director, !director.isEmpty {
            metadata.append(director.prefix(2).joined(separator: metadataArraySeparator))
        }
        if let actor = actor, !actor.isEmpty {
            metadata.append(actor.prefix(3).joined(separator: metadataArraySeparator))
        }
        if let seasonCount = seasonCount {
            metadata.append(LocalizableMetadata.seasonCountFormatted(count: seasonCount).displayName)
        }
        if let episodeCount = episodeCount {
            metadata.append(LocalizableMetadata.episodeCountFormatted(count: episodeCount).displayName)
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if let director = director, !director.isEmpty {
            metadata.append((LocalizableMetadata.director.displayName, director.joined(separator: metadataArraySeparator)))
        }
        if let playwright = playwright, !playwright.isEmpty {
            metadata.append((LocalizableMetadata.playwright.displayName, playwright.joined(separator: metadataArraySeparator)))
        }
        if let actor = actor, !actor.isEmpty {
            metadata.append((LocalizableMetadata.actor.displayName, actor.joined(separator: metadataArraySeparator)))
        }
        if let genre = genre, !genre.isEmpty {
            metadata.append((LocalizableMetadata.genre.displayName, genre.joined(separator: metadataArraySeparator)))
        }
        if let language = language, !language.isEmpty {
            let languageDisplayNames = language.compactMap { $0.displayNameWithoutUnknown }
            if !languageDisplayNames.isEmpty {
                metadata.append((LocalizableMetadata.language.displayName, languageDisplayNames.joined(separator: metadataArraySeparator)))
            }
        }
        if let area = area, !area.isEmpty {
            metadata.append((LocalizableMetadata.area.displayName, area.joined(separator: metadataArraySeparator)))
        }
        if let year = year {
            metadata.append((LocalizableMetadata.year.displayName, String(year)))
        }
        if let imdb = imdb {
            metadata.append((LocalizableMetadata.imdb.displayName, imdb))
        }
        if let episodeCount = episodeCount {
            metadata.append((LocalizableMetadata.episodeCount.displayName, String(episodeCount)))
        }
        if let episodeNumber = episodeNumber {
            metadata.append((LocalizableMetadata.episodeNumber.displayName, String(episodeNumber)))
        }
        if let seasonNumber = seasonNumber {
            metadata.append((LocalizableMetadata.seasonNumber.displayName, String(seasonNumber)))
        }
        return metadata
    }
}

// MARK: - TV Season Schema
//struct TVSeasonSchema: ItemProtocol {
//    let id: String
//    let type: ItemType
//    let uuid: String
//    let url: String
//    let apiUrl: String
//    let category: ItemCategory
//    let parentUuid: String?
//    let displayTitle: String?
//    let externalResources: [ItemExternalResourceSchema]?
//    let title: String?
//    let description: String?
//    let localizedTitle: [ItemLocalizedText]?
//    let localizedDescription: [ItemLocalizedText]?
//    let coverImageUrl: URL?
//    let rating: Double?
//    let ratingCount: Int?
//    let ratingDistribution: [Int]?
//    let brief: String
//
//    // Additional properties specific to TV Season
//    let seasonNumber: Int?
//    let origTitle: String?
//    let otherTitle: [String]
//    let director: [String]
//    let playwright: [String]
//    let actor: [String]
//    let genre: [String]
//    let language: [String]
//    let area: [String]
//    let year: Int?
//    let site: String?
//    let episodeCount: Int?
//    let episodeUuids: [String]
//    let imdb: String?
//}

// MARK: - TV Episode Schema
//struct TVEpisodeSchema: ItemProtocol {
//    let id: String
//    let type: ItemType
//    let uuid: String
//    let url: String
//    let apiUrl: String
//    let category: ItemCategory
//    let parentUuid: String?
//    let displayTitle: String?
//    let externalResources: [ItemExternalResourceSchema]?
//    let title: String?
//    let description: String?
//    let localizedTitle: [ItemLocalizedText]?
//    let localizedDescription: [ItemLocalizedText]?
//    let coverImageUrl: URL?
//    let rating: Double?
//    let ratingCount: Int?
//    let ratingDistribution: [Int]?
//    let brief: String
//
//    // Additional properties specific to TV Episode
//    let episodeNumber: Int?
//}
