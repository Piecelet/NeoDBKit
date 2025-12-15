//
//  ItemPodcastSchema.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

fileprivate let metadataArraySeparator = " "

// MARK: - Podcast Schema
public struct ItemPodcastSchema: ItemProtocol {
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

    // Additional properties specific to Podcast
    // public var origTitle: String? = nil
    // public var otherTitle: [String]? = nil
    // public var lastEpisodeDate: String? = nil
    // public var episodeCount: Int? = nil
    // public var rssUrl: String? = nil
    public var genre: [String]? = nil
    public var host: [String]? = nil
    public var language: [ItemLocalizedText.KnownLanguage]? = nil
    public var officialSite: String? = nil
    @available(*, deprecated, message: "Hosts of Podcast is deprecated, use host instead.")
    public var hosts: [String]? = nil

    // Additional properties specific to Podcast Episode
    public var guid: String? = nil
    public var pubDate: ServerDate? = nil
    public var mediaUrl: String? = nil
    public var link: String? = nil
    public var duration: Int? = nil
}

extension ItemPodcastSchema {
    public enum LocalizableMetadata {
        case title
        case description
        case type
        case category

        // Additional properties specific to Podcast
        case host
        case genre
        case language
        case officialSite

        // Additional properties specific to Podcast Episode
        case pubDate
        case duration
        case link

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
            case .host:
                return String(localized: "neodb.item.schema.podcast.metadata.host.label", defaultValue: "Host", bundle: .module, comment: "Podcast Host label")
            case .genre:
                return String(localized: "neodb.item.schema.podcast.metadata.genre.label", defaultValue: "Genre", bundle: .module, comment: "Podcast Genre label")
            case .language:
                return String(localized: "neodb.item.schema.podcast.metadata.language.label", defaultValue: "Language", bundle: .module, comment: "Podcast Language label")
            case .officialSite:
                return String(localized: "neodb.item.schema.podcast.metadata.official_site.label", defaultValue: "Official Site", bundle: .module, comment: "Podcast Official Site label")
            case .pubDate:
                return String(localized: "neodb.item.schema.podcast_episode.metadata.pubdate.label", defaultValue: "Publication Date", bundle: .module, comment: "Podcast Publication Date label")
            case .duration:
                return String(localized: "neodb.item.schema.podcast_episode.metadata.duration.label", defaultValue: "Duration", bundle: .module, comment: "Podcast Duration label")
            case .link:
                return String(localized: "neodb.item.schema.podcast_episode.metadata.link.label", defaultValue: "Link", bundle: .module, comment: "Podcast Link label")
            }
        }
    }
}

extension ItemPodcastSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if let host = host, !host.isEmpty {
            metadata.append(host.joined(separator: metadataArraySeparator))
        }
        if let genre = genre, !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        if let pubDate = pubDate {
            metadata.append(pubDate.formatted(.dateOnly))
        }
        if let language = language, !language.isEmpty {
            let languageDisplayNames = language.compactMap { $0.displayNameCodeAndNameAbbreviatedInChineseWithoutUnknown }
            if !languageDisplayNames.isEmpty {
                metadata.append(languageDisplayNames.joined(separator: metadataArraySeparator))
            }
        }
        // if let episodeCount = episodeCount {
        //     metadata.append(LocalizableMetadata.episodeCountFormatted(count: episodeCount).displayName)
        // }
        // if let lastEpisodeDate = lastEpisodeDate {
        //     metadata.append(lastEpisodeDate)
        // }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if let host = host, !host.isEmpty {
            metadata.append((LocalizableMetadata.host.displayName, host.joined(separator: metadataArraySeparator)))
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
        if let pubDate = pubDate {
            metadata.append((LocalizableMetadata.pubDate.displayName, pubDate.formatted(.dateOnly)))
        }
        // if let episodeCount = episodeCount {
        //     metadata.append((LocalizableMetadata.episodeCountFormatted(count: episodeCount).displayName, String(episodeCount)))
        // }
        // if let lastEpisodeDate = lastEpisodeDate {
        //     metadata.append((LocalizableMetadata.lastEpisodeDate.displayName, lastEpisodeDate))
        // }
        // if let rssUrl = rssUrl {
        //     metadata.append((LocalizableMetadata.rssUrl.displayName, rssUrl))
        // }
        // if let websiteUrl = websiteUrl {
        //     metadata.append((LocalizableMetadata.websiteUrl.displayName, websiteUrl))
        // }
        if let link = link {
            metadata.append((LocalizableMetadata.link.displayName, link))
        }
        if let duration = duration {
            let durationString = String(format: "%02d:%02d:%02d", duration / 3600, (duration % 3600) / 60, duration % 60)
            metadata.append((LocalizableMetadata.duration.displayName, durationString))
        }
        return metadata
    }
}

//public struct PodcastEpisodeSchema: ItemProtocol {
//    public let id: ItemID
//    public let type: ItemType
//    public let uuid: ItemUUID
//    public let url: String
//    public let apiUrl: String
//    public let category: ItemCategory
//    public let parentUuid: ItemUUID?
//    public let displayTitle: String?
//    public let externalResources: [ItemExternalResourceSchema]?
//    public let title: String?
//    public let description: String?
//    public let localizedTitle: [ItemLocalizedText]?
//    public let localizedDescription: [ItemLocalizedText]?
//    public let coverImageUrl: URL?
//    public let rating: Double?
//    public let ratingCount: Int?
//    public let ratingDistribution: [Int]?
//    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
//    public let brief: String?
//
//    // Additional properties specific to Podcast Episode
//    public let guid: String?
//    public let pubDate: ServerDate?
//    public let mediaUrl: String?
//    public let link: String?
//    public let duration: Int?
//}
