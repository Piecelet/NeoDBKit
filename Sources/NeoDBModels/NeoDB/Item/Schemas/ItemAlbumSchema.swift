//
//  ItemAlbumSchema.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

fileprivate let metadataArraySeparator = " "

// MARK: - Album Schema
public struct ItemAlbumSchema: ItemProtocol {
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

    // Additional properties specific to Album
    public var otherTitle: [String]? = nil
    public var genre: [String] = []
    public var artist: [String] = []
    public var company: [String] = []
    public var duration: Int? = nil  // in milliseconds
    public var releaseDate: String? = nil
    public var trackList: String? = nil
    public var barcode: String? = nil

    public var durationString: String? {
        if let duration = duration {
            let totalSeconds = duration / 1000  // Convert milliseconds to seconds
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }
        return nil
    }
}

extension ItemAlbumSchema {
    public enum LocalizableMetadata: CaseIterable {
        case title
        case description
        case type
        case category

        case genre
        case artist
        case company
        case releaseDate
        case duration
        case trackList
        case barcode

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
                return String(localized: "neodb.item.schema.album.metadata.genre.label", defaultValue: "Genre", bundle: .module, comment: "Album Genre label")
            case .artist:
                return String(localized: "neodb.item.schema.album.metadata.artist.label", defaultValue: "Artist", bundle: .module, comment: "Album Artist label")
            case .company:
                return String(localized: "neodb.item.schema.album.metadata.company.label", defaultValue: "Company", bundle: .module, comment: "Album Company label")
            case .releaseDate:
                return String(localized: "neodb.item.schema.album.metadata.release_date.label", defaultValue: "Release Date", bundle: .module, comment: "Album Release Date label")
            case .duration:
                return String(localized: "neodb.item.schema.album.metadata.duration.label", defaultValue: "Duration", bundle: .module, comment: "Album Duration label")
            case .trackList:
                return String(localized: "neodb.item.schema.album.metadata.track_list.label", defaultValue: "Track List", bundle: .module, comment: "Album Track List label")
            case .barcode:
                return String(localized: "neodb.item.schema.album.metadata.barcode.label", defaultValue: "Barcode", bundle: .module, comment: "Album Barcode label")
            }
        }
    }
}

extension AlbumSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if !artist.isEmpty {
            metadata.append(artist.joined(separator: metadataArraySeparator))
        }
        if !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        if let releaseDate = releaseDate {
            metadata.append(releaseDate)
        }
        if let durationString = durationString {
            metadata.append(durationString)
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !genre.isEmpty {
            metadata.append((LocalizableMetadata.genre.displayName, genre.joined(separator: metadataArraySeparator)))
        }
        if !artist.isEmpty {
            metadata.append((LocalizableMetadata.artist.displayName, artist.joined(separator: metadataArraySeparator)))
        }
        if !company.isEmpty {
            metadata.append((LocalizableMetadata.company.displayName, company.joined(separator: metadataArraySeparator)))
        }
        if let barcode = barcode {
            metadata.append((LocalizableMetadata.barcode.displayName, barcode))
        }
        if let releaseDate = releaseDate {
            metadata.append((LocalizableMetadata.releaseDate.displayName, releaseDate))
        }
        if let durationString = durationString {
            metadata.append((LocalizableMetadata.duration.displayName, durationString))
        }
        if let trackList = trackList {
            metadata.append((LocalizableMetadata.trackList.displayName, trackList))
        }
        return metadata
    }
}
