//
//  ItemGameSchema.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

fileprivate let metadataArraySeparator = " "

// MARK: - Game Schema
public struct ItemGameSchema: ItemProtocol {
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
    
    // Additional properties specific to Game
    // public var origTitle: String? = nil
    public var genre: [String] = []
    public var developer: [String] = []
    public var publisher: [String] = []
    public var platform: [String]? = nil
    public var releaseType: String? = nil
    public var releaseDate: String? = nil
    // public let releaseDateJP: String?
    // public let releaseDateUS: String?
    // public let releaseDateEU: String?
    public var officialSite: String? = nil
}

extension ItemGameSchema {
    public enum LocalizableMetadata: CaseIterable {
        case title
        case description
        case type
        case category

        case genre
        case developer
        case publisher
        case platform
        case releaseType
        case releaseDate
        case officialSite

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
            case .genre:
                return String(localized: "neodb.item.schema.game.metadata.genre.label", defaultValue: "Genre", bundle: .module, comment: "Game Genre label")
            case .developer:
                return String(localized: "neodb.item.schema.game.metadata.developer.label", defaultValue: "Developer", bundle: .module, comment: "Game Developer label")
            case .publisher:
                return String(localized: "neodb.item.schema.game.metadata.publisher.label", defaultValue: "Publisher", bundle: .module, comment: "Game Publisher label")
            case .platform:
                return String(localized: "neodb.item.schema.game.metadata.platform.label", defaultValue: "Platform", bundle: .module, comment: "Game Platform label")
            case .releaseType:
                return String(localized: "neodb.item.schema.game.metadata.release_type.label", defaultValue: "Release Type", bundle: .module, comment: "Game Release Type label")
            case .releaseDate:
                return String(localized: "neodb.item.schema.game.metadata.release_date.label", defaultValue: "Release Date", bundle: .module, comment: "Game Release Date label")
            case .officialSite:
                return String(localized: "neodb.item.schema.game.metadata.official_site.label", defaultValue: "Official Site", bundle: .module, comment: "Game Official Site label")
            }
        }
    }
}

extension ItemGameSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        if !developer.isEmpty {
            metadata.append(developer.joined(separator: metadataArraySeparator))
        }
        if !publisher.isEmpty {
            metadata.append(publisher.joined(separator: metadataArraySeparator))
        }
        if let platform = platform, !platform.isEmpty {
            metadata.append(platform.joined(separator: metadataArraySeparator))
        }
        if let releaseType = releaseType, !releaseType.isEmpty {
            metadata.append(releaseType)
        }
        if let releaseDate = releaseDate, !releaseDate.isEmpty {
            metadata.append(releaseDate)
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !genre.isEmpty {
            metadata.append((LocalizableMetadata.genre.displayName, genre.joined(separator: metadataArraySeparator)))
        }
        if !developer.isEmpty {
            metadata.append((LocalizableMetadata.developer.displayName, developer.joined(separator: metadataArraySeparator)))
        }
        if !publisher.isEmpty {
            metadata.append((LocalizableMetadata.publisher.displayName, publisher.joined(separator: metadataArraySeparator)))
        }
        if let platform = platform, !platform.isEmpty {
            metadata.append((LocalizableMetadata.platform.displayName, platform.joined(separator: metadataArraySeparator)))
        }
        if let releaseType = releaseType, !releaseType.isEmpty {
            metadata.append((LocalizableMetadata.releaseType.displayName, releaseType))
        }
        if let releaseDate = releaseDate, !releaseDate.isEmpty {
            metadata.append((LocalizableMetadata.releaseDate.displayName, releaseDate))
        }
        if let officialSite = officialSite, !officialSite.isEmpty {
            metadata.append((LocalizableMetadata.officialSite.displayName, officialSite))
        }
        return metadata
    }
}
