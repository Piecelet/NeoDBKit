//
//  ItemMovieSchema.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

fileprivate let metadataArraySeparator = " "

// MARK: - Movie Schema
public struct ItemMovieSchema: ItemProtocol {
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

    // Additional properties specific to Movie
    public var origTitle: String? = nil
    @available(*, deprecated, message: "otherTitle is deprecated since NeoDB is no longer have it.")
    public var otherTitle: [String]? = nil
    public var director: [String] = []
    public var playwright: [String] = []
    public var actor: [String] = []
    public var genre: [String] = []
    public var language: [ItemLocalizedText.KnownLanguage] = []
    public var area: [String] = [] {
        didSet {
            let sanitized = Self.sanitizeAreaValues(area)
            if sanitized != area {
                area = sanitized
            }
        }
    }
    public var year: Int? = nil
    public var site: String? = nil
    public var duration: String? = nil
    public var imdb: String? = nil
}

extension ItemMovieSchema {
    public enum LocalizableMetadata: CaseIterable {
        case title
        case description
        case type
        case category

        case director
        case playwright
        case actor
        case genre
        case language
        case area
        case year
        case duration
        case imdb

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
                return String(localized: "neodb.item.schema.movie.metadata.director.label", defaultValue: "Director", bundle: .module, comment: "Movie Director label")
            case .playwright:
                return String(localized: "neodb.item.schema.movie.metadata.playwright.label", defaultValue: "Playwright", bundle: .module, comment: "Movie Playwright label")
            case .actor:
                return String(localized: "neodb.item.schema.movie.metadata.actor.label", defaultValue: "Actor", bundle: .module, comment: "Movie Actor label")
            case .genre:
                return String(localized: "neodb.item.schema.movie.metadata.genre.label", defaultValue: "Genre", bundle: .module, comment: "Movie Genre label")
            case .language:
                return String(localized: "neodb.item.schema.movie.metadata.language.label", defaultValue: "Language", bundle: .module, comment: "Movie Language label")
            case .area:
                return String(localized: "neodb.item.schema.movie.metadata.area.label", defaultValue: "Area", bundle: .module, comment: "Movie Area label")
            case .year:
                return String(localized: "neodb.item.schema.movie.metadata.year.label", defaultValue: "Year", bundle: .module, comment: "Movie Year label")
            case .duration:
                return String(localized: "neodb.item.schema.movie.metadata.duration.label", defaultValue: "Duration", bundle: .module, comment: "Movie Duration label")
            case .imdb:
                return String(localized: "neodb.item.schema.movie.metadata.imdb.label", defaultValue: "IMDB", bundle: .module, comment: "Movie IMDB label")
            }
        }
    }
}

extension MovieSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if !area.isEmpty {
            metadata.append(area.joined(separator: metadataArraySeparator))
        }
        if !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        if !language.isEmpty {
            let languageDisplayNames = language.compactMap { $0.displayNameCodeAndNameAbbreviatedInChineseWithoutUnknown }
            if !languageDisplayNames.isEmpty {
                metadata.append(languageDisplayNames.joined(separator: metadataArraySeparator))
            }
        }
        if !director.isEmpty {
            metadata.append(director.prefix(2).joined(separator: metadataArraySeparator))
        }
        if !actor.isEmpty {
            metadata.append(actor.prefix(5).joined(separator: metadataArraySeparator))
        }
        if let duration = duration {
            metadata.append(duration)
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !director.isEmpty {
            metadata.append((LocalizableMetadata.director.displayName, director.joined(separator: metadataArraySeparator)))
        }
        if !playwright.isEmpty {
            metadata.append((LocalizableMetadata.playwright.displayName, playwright.joined(separator: metadataArraySeparator)))
        }
        if !actor.isEmpty {
            metadata.append((LocalizableMetadata.actor.displayName, actor.joined(separator: metadataArraySeparator)))
        }
        if !genre.isEmpty {
            metadata.append((LocalizableMetadata.genre.displayName, genre.joined(separator: metadataArraySeparator)))
        }
        if !language.isEmpty {
            let languageDisplayNames = language.compactMap { $0.displayNameWithoutUnknown }
            if !languageDisplayNames.isEmpty {
                metadata.append((LocalizableMetadata.language.displayName, languageDisplayNames.joined(separator: metadataArraySeparator)))
            }
        }
        if !area.isEmpty {
            metadata.append((LocalizableMetadata.area.displayName, area.joined(separator: metadataArraySeparator)))
        }
        if let year = year {
            metadata.append((LocalizableMetadata.year.displayName, String(year)))
        }
        if let duration = duration {
            metadata.append((LocalizableMetadata.duration.displayName, duration))
        }
        if let imdb = imdb {
            metadata.append((LocalizableMetadata.imdb.displayName, imdb))
        }
        return metadata
    }
}
