//
//  Item.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import Foundation

private let metadataArraySeparator = " "
private let metadataArraySeparatorHidden = " "

// MARK: - Base Item Protocol
public protocol ItemProtocol: Codable, Decodable, Equatable, Hashable, Identifiable {
    var id: ItemID { get }
    var type: ItemType { get }
    var uuid: ItemUUID { get }
    var url: String { get }
    var apiUrl: String { get }
    var category: ItemCategory { get }
    var parentUuid: ItemUUID? { get }
    var displayTitle: String? { get }
    var externalResources: [ItemExternalResourceSchema]? { get }
    var title: String? { get }
    var description: String? { get }
    var localizedTitle: [LocalizedTitleSchema]? { get }
    var localizedDescription: [LocalizedTitleSchema]? { get }
    var coverImageUrl: URL? { get }
    var rating: Double? { get }
    var ratingCount: Int? { get }
    var ratingDistribution: [Int]? { get }
    // var ratingDistribution: [Int: Int]? { get }
    // var tags: [String]? { get }
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    var brief: String? { get }
}

// Default implementation for Hashable
extension ItemProtocol {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public var toItemSchema: ItemSchema {
        return ItemSchema(
            id: self.id,
            type: self.type,
            uuid: self.uuid,
            url: self.url,
            apiUrl: self.apiUrl,
            category: self.category,
            parentUuid: self.parentUuid,
            displayTitle: self.displayTitle,
            externalResources: self.externalResources,
            title: self.title,
            description: self.description,
            localizedTitle: self.localizedTitle,
            localizedDescription: self.localizedDescription,
            coverImageUrl: self.coverImageUrl,
            rating: self.rating,
            ratingCount: self.ratingCount,
            ratingDistribution: self.ratingDistribution,
            brief: nil
        )
    }
}

// MARK: - Base Item Schema
public struct ItemSchema: ItemProtocol, Sendable {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    public init(
        id: ItemID,
        type: ItemType,
        uuid: ItemUUID,
        url: String,
        apiUrl: String,
        category: ItemCategory,
        parentUuid: ItemUUID? = nil,
        displayTitle: String? = nil,
        externalResources: [ItemExternalResourceSchema]? = nil,
        title: String? = nil,
        description: String? = nil,
        localizedTitle: [LocalizedTitleSchema]? = nil,
        localizedDescription: [LocalizedTitleSchema]? = nil,
        coverImageUrl: URL? = nil,
        rating: Double? = nil,
        ratingCount: Int? = nil,
        ratingDistribution: [Int]? = nil,
        brief: String? = nil
    ) {
        self.id = id
        self.type = type
        self.uuid = uuid
        self.url = url
        self.apiUrl = apiUrl
        self.category = category
        self.parentUuid = parentUuid
        self.displayTitle = displayTitle
        self.externalResources = externalResources
        self.title = title
        self.description = description
        self.localizedTitle = localizedTitle
        self.localizedDescription = localizedDescription
        self.coverImageUrl = coverImageUrl
        self.rating = rating
        self.ratingCount = ratingCount
        self.ratingDistribution = ratingDistribution
        self.brief = brief
    }
}

extension ItemSchema {
    @available(*, deprecated, message: "Use ItemSchema.makeTemporaryItemSchema(uuid: String) instead.")
    public static func makeTemporaryItemSchema(uuid: String) -> ItemSchema {
        return ItemSchema.makeTemporaryItemSchema(id: URL(string: "https://unknown.neodb.net/unknown/\(uuid)")!)
    }

    public static func makeTemporaryItemSchema(id: URL) -> ItemSchema {
        return ItemSchema(
            id: id.absoluteString,
            type: .unknown,
            uuid: id.lastPathComponent.components(separatedBy: "/").last ?? id.absoluteString,
            url: "",
            apiUrl: "",
            category: .book,
            parentUuid: nil,
            displayTitle: nil,
            externalResources: nil,
            title: nil,
            description: nil,
            localizedTitle: nil,
            localizedDescription: nil,
            coverImageUrl: nil,
            rating: nil,
            ratingCount: nil,
            ratingDistribution: nil,
            brief: nil
        )
    }

    public static func makeType(category: ItemCategory) -> any ItemProtocol.Type {
        switch category {
        case .book, .collection:
            return EditionSchema.self
        case .movie:
            return MovieSchema.self
        case .tv:
            return TVShowSchema.self
        case .music:
            return AlbumSchema.self
        case .podcast:
            return PodcastSchema.self
        case .game:
            return GameSchema.self
        case .performance:
            return PerformanceSchema.self
        }
    }
}

extension ItemSchema {
    public static var placeholder: ItemSchema {
        return .init(
            id: "https://piecelet.internal/placeholder",
            type: .unknown,
            uuid: "placeholder",
            url: "https://piecelet.internal/placeholder",
            apiUrl: "https://piecelet.internal/placeholder",
            category: .book,
            parentUuid: nil,
            displayTitle: "placeholder",
            externalResources: [],
            title: "placeholder",
            description: "placeholder",
            localizedTitle: nil,
            localizedDescription: nil,
            coverImageUrl: URL(string: "https://piecelet.internal/placeholder")!,
            rating: 5,
            ratingCount: 46,
            ratingDistribution: nil,
            brief: "placeholder"
        )
    }

    public static var placeholders: [ItemSchema] {
        return [
            .placeholder,
            .placeholder,
            .placeholder,
            .placeholder,
            .placeholder,
            .placeholder,
            .placeholder,
            .placeholder,
            .placeholder,
            .placeholder
        ]
    }
}

// MARK: - Edition Schema
public struct EditionSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to Edition
    public let subtitle: String?
    public let origTitle: String?
    public let author: [String]
    public let translator: [String]
    public let language: [String]
    public let pubHouse: String?
    public let pubYear: Int?
    public let pubMonth: Int?
    public let binding: String?
    public let price: String?
    public let pages: Int?
    public let series: String?
    public let imprint: String?
    public let isbn: String?
}

extension EditionSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if let author = author.first {
            metadata.append(author)
        }
        if let pubHouse = pubHouse {
            metadata.append(pubHouse)
        }
        if let pubYear = pubYear {
            metadata.append(String(pubYear))
        }
        if let pages = pages {
            metadata.append(String(format: String(localized: "metadata_book_pages_format", table: "Item", comment: "Book Pages format"), pages))
        }

        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !author.isEmpty {
            metadata.append((String(localized: "metadata_book_author_label", table: "Item", comment: "Book Author label"), author.joined(separator: metadataArraySeparator)))
        }
        if !translator.isEmpty {
            metadata.append((String(localized: "metadata_book_translator_label", table: "Item", comment: "Book Translator label"), translator.joined(separator: metadataArraySeparator)))
        }
        if !language.isEmpty {
            metadata.append((String(localized: "metadata_book_language_label", table: "Item", comment: "Book Language label"), language.joined(separator: metadataArraySeparator)))
        }
        if let pubHouse = pubHouse {
            metadata.append((String(localized: "metadata_book_publisher_label", table: "Item", comment: "Book Publisher label"), pubHouse))
        }
        if let pubYear = pubYear {
            metadata.append((String(localized: "metadata_book_pub_year_label", table: "Item", comment: "Book Publication Date Year label"), String(pubYear)))
        }
        if let pubMonth = pubMonth {
            metadata.append((String(localized: "metadata_book_pub_month_label", table: "Item", comment: "Book Publication Date Month label"), String(pubMonth)))
        }
        if let binding = binding {
            metadata.append((String(localized: "metadata_book_binding_label", table: "Item", comment: "Book Binding label"), binding))
        }
        if let price = price {
            metadata.append((String(localized: "metadata_book_price_label", table: "Item", comment: "Book Price label"), price))
        }
        if let pages = pages {
            metadata.append((String(localized: "metadata_book_pages_label", table: "Item", comment: "Book Pages label"), String(pages)))
        }
        if let series = series {
            metadata.append((String(localized: "metadata_book_series_label", table: "Item", comment: "Book Series label"), series))
        }
        if let imprint = imprint {
            metadata.append((String(localized: "metadata_book_imprint_label", table: "Item", comment: "Book Imprint label"), imprint))
        }
        if let isbn = isbn {
            metadata.append((String(localized: "metadata_book_isbn_label", table: "Item", comment: "Book ISBN label"), isbn))
        }
        return metadata
    }
}

// MARK: - Movie Schema
public struct MovieSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to Movie
    public let origTitle: String?
    public let otherTitle: [String]?
    public let director: [String]
    public let playwright: [String]
    public let actor: [String]
    public let genre: [String]
    public let language: [String]
    public let area: [String]
    public let year: Int?
    public let site: String?
    public let duration: String?
    public let imdb: String?
}

extension MovieSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if !area.isEmpty {
            metadata.append(area.joined(separator: metadataArraySeparatorHidden))
        }
        if !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        if !language.isEmpty {
            metadata.append(language.joined(separator: metadataArraySeparator))
        }
        if let duration = duration {
            metadata.append(duration)
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !director.isEmpty {
            metadata.append((String(localized: "metadata_movie_director_label", table: "Item", comment: "Movie Director label"), director.joined(separator: metadataArraySeparator)))
        }
        if !playwright.isEmpty {
            metadata.append((String(localized: "metadata_movie_playwright_label", table: "Item", comment: "Movie Playwright label"), playwright.joined(separator: metadataArraySeparator)))
        }
        if !actor.isEmpty {
            metadata.append((String(localized: "metadata_movie_actor_label", table: "Item", comment: "Movie Actor label"), actor.joined(separator: metadataArraySeparator)))
        }
        if !genre.isEmpty {
            metadata.append((String(localized: "metadata_movie_genre_label", table: "Item", comment: "Movie Genre label"), genre.joined(separator: metadataArraySeparator)))
        }
        if !language.isEmpty {
            metadata.append((String(localized: "metadata_movie_language_label", table: "Item", comment: "Movie Language label"), language.joined(separator: metadataArraySeparator)))
        }
        if !area.isEmpty {
            metadata.append((String(localized: "metadata_movie_area_label", table: "Item", comment: "Movie Area label"), area.joined(separator: metadataArraySeparatorHidden)))
        }
        if let year = year {
            metadata.append((String(localized: "metadata_movie_year_label", table: "Item", comment: "Movie Year label"), String(year)))
        }
        if let duration = duration {
            metadata.append((String(localized: "metadata_movie_duration_label", table: "Item", comment: "Movie Duration label"), duration))
        }
        if let imdb = imdb {
            metadata.append((String(localized: "metadata_movie_imdb_label", table: "Item", comment: "Movie IMDB label"), imdb))
        }
        return metadata
    }
}

// MARK: - TV Show Schema
public struct TVShowSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to TV Show
    public let seasonCount: Int?
    public let origTitle: String?
    public let otherTitle: [String]?
    public let director: [String]?
    public let playwright: [String]?
    public let actor: [String]?
    public let genre: [String]?
    public let language: [String]?
    public let area: [String]?
    public let year: Int?
    public let site: String?
    public let episodeCount: Int?
    public let imdb: String?

    // TV Show Schema
    public let seasonUuids: [ItemUUID]?

    // TV Season Schema
    public let seasonNumber: Int?
    public let episodeUuids: [ItemUUID]?

    // TV Episode Schema
    public let episodeNumber: Int?
}

extension TVShowSchema {

    public var keyMetadata: [String] {
        var metadata: [String] = []

        if let area = area, !area.isEmpty {
            metadata.append(area.joined(separator: metadataArraySeparatorHidden))
        }
        if let genre = genre, !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        if let language = language, !language.isEmpty {
            metadata.append(language.joined(separator: metadataArraySeparator))
        }
        if let seasonCount = seasonCount {
            metadata.append(String(format: String(localized: "metadata_tv_season_count_format", table: "Item", comment: "TV Show Season Count format"), seasonCount))
        }
        if let episodeCount = episodeCount {
            metadata.append(String(format: String(localized: "metadata_tv_episode_count_format", table: "Item", comment: "TV Show Episode Count format"), episodeCount))
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if let director = director, !director.isEmpty {
            metadata.append((String(localized: "metadata_tv_director_label", table: "Item", comment: "TV Show Director label"), director.joined(separator: metadataArraySeparator)))
        }
        if let playwright = playwright, !playwright.isEmpty {
            metadata.append((String(localized: "metadata_tv_playwright_label", table: "Item", comment: "TV Show Playwright label"), playwright.joined(separator: metadataArraySeparator)))
        }
        if let actor = actor, !actor.isEmpty {
            metadata.append((String(localized: "metadata_tv_actor_label", table: "Item", comment: "TV Show Actor label"), actor.joined(separator: metadataArraySeparator)))
        }
        if let genre = genre, !genre.isEmpty {
            metadata.append((String(localized: "metadata_tv_genre_label", table: "Item", comment: "TV Show Genre label"), genre.joined(separator: metadataArraySeparator)))
        }
        if let language = language, !language.isEmpty {
            metadata.append((String(localized: "metadata_tv_language_label", table: "Item", comment: "TV Show Language label"), language.joined(separator: metadataArraySeparator)))
        }
        if let area = area, !area.isEmpty {
            metadata.append((String(localized: "metadata_tv_area_label", table: "Item", comment: "TV Show Area label"), area.joined(separator: metadataArraySeparatorHidden)))
        }
        if let year = year {
            metadata.append((String(localized: "metadata_tv_year_label", table: "Item", comment: "TV Show Year label"), String(year)))
        }
        if let imdb = imdb {
            metadata.append((String(localized: "metadata_tv_imdb_label", table: "Item", comment: "TV Show IMDB ID label"), imdb))
        }
        if let episodeCount = episodeCount {
            metadata.append((String(localized: "metadata_tv_episode_count_label", table: "Item", comment: "TV Show Episode Count label"), String(episodeCount)))
        }
        if let episodeNumber = episodeNumber {
            metadata.append((String(localized: "metadata_tv_episode_number_label", table: "Item", comment: "TV Show Episode Number label"), String(episodeNumber)))
        }
        if let seasonNumber = seasonNumber {
            metadata.append((String(localized: "metadata_tv_season_number_label", table: "Item", comment: "TV Show Season Number label"), String(seasonNumber)))
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
//    let localizedTitle: [LocalizedTitleSchema]?
//    let localizedDescription: [LocalizedTitleSchema]?
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
//    let localizedTitle: [LocalizedTitleSchema]?
//    let localizedDescription: [LocalizedTitleSchema]?
//    let coverImageUrl: URL?
//    let rating: Double?
//    let ratingCount: Int?
//    let ratingDistribution: [Int]?
//    let brief: String
//    
//    // Additional properties specific to TV Episode
//    let episodeNumber: Int?
//}

// MARK: - Album Schema
public struct AlbumSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to Album
    public let otherTitle: [String]?
    public let genre: [String]
    public let artist: [String]
    public let company: [String]
    public let duration: Int?
    public let releaseDate: String?
    public let trackList: String?
    public let barcode: String?

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
            metadata.append((String(localized: "metadata_album_genre_label", table: "Item", comment: "Album Genre label"), genre.joined(separator: metadataArraySeparator)))
        }
        if !artist.isEmpty {
            metadata.append((String(localized: "metadata_album_artist_label", table: "Item", comment: "Album Artist label"), artist.joined(separator: metadataArraySeparator)))
        }
        if !company.isEmpty {
            metadata.append((String(localized: "metadata_album_company_label", table: "Item", comment: "Album Company label"), company.joined(separator: metadataArraySeparator)))
        }
        if let barcode = barcode {
            metadata.append((String(localized: "metadata_album_barcode_label", table: "Item", comment: "Album Barcode label"), barcode))
        }
        if let releaseDate = releaseDate {
            metadata.append((String(localized: "metadata_album_release_date_label", table: "Item", comment: "Album Release Date label"), releaseDate))
        }
        if let durationString = durationString {
            metadata.append((String(localized: "metadata_album_duration_label", table: "Item", comment: "Album Duration label"), durationString))
        }
        if let trackList = trackList {
            metadata.append((String(localized: "metadata_album_track_list_label", table: "Item", comment: "Album Track List label"), trackList))
        }
        return metadata
    }
}

// MARK: - Podcast Schema
public struct PodcastSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to Podcast
    public let host: [String]
    public let origTitle: String?
    public let otherTitle: [String]?
    public let genre: [String]
    public let language: [String]
    public let episodeCount: Int?
    public let lastEpisodeDate: String?
    public let rssUrl: String?
    public let websiteUrl: String?
}

extension PodcastSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if !host.isEmpty {
            metadata.append(host.joined(separator: metadataArraySeparator))
        }
        if !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        if !language.isEmpty {
            metadata.append(language.joined(separator: metadataArraySeparator))
        }
        if let episodeCount = episodeCount {
            metadata.append(String(format: String(localized: "metadata_podcast_episode_count_format", table: "Item", comment: "Podcast Episode Count formatted"), episodeCount))
        }
        if let lastEpisodeDate = lastEpisodeDate {
            metadata.append(lastEpisodeDate)
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !host.isEmpty {
            metadata.append((String(localized: "metadata_podcast_host_label", table: "Item", comment: "Podcast Host label"), host.joined(separator: metadataArraySeparator)))
        }
        if !genre.isEmpty {
            metadata.append((String(localized: "metadata_podcast_genre_label", table: "Item", comment: "Podcast Genre label"), genre.joined(separator: metadataArraySeparator)))
        }
        if !language.isEmpty {
            metadata.append((String(localized: "metadata_podcast_language_label", table: "Item", comment: "Podcast Language label"), language.joined(separator: metadataArraySeparator)))
        }
        if let episodeCount = episodeCount {
            metadata.append((String(localized: "metadata_podcast_episode_count_label", table: "Item", comment: "Podcast Episode Count label"), String(episodeCount)))
        }
        if let lastEpisodeDate = lastEpisodeDate {
            metadata.append((String(localized: "metadata_podcast_last_episode_date_label", table: "Item", comment: "Podcast Last Episode Date label"), lastEpisodeDate))
        }
        if let rssUrl = rssUrl {
            metadata.append((String(localized: "metadata_podcast_rss_url_label", table: "Item", comment: "Podcast RSS URL label"), rssUrl))
        }
        if let websiteUrl = websiteUrl {
            metadata.append((String(localized: "metadata_podcast_website_url_label", table: "Item", comment: "Podcast Website URL label"), websiteUrl))
        }
        return metadata
    }
}

public struct PodcastEpisodeSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to Podcast Episode
    public let guid: String?
    public let pubDate: ServerDate?
    public let mediaUrl: String?
    public let link: String?
    public let duration: Int?
}

extension PodcastEpisodeSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

       if let pubDate = pubDate {
           metadata.append(pubDate.formatted(.dateOnly))
       }

        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if let pubDate = pubDate {
            metadata.append((String(localized: "metadata_podcast_episode_pub_date_label", table: "Item", comment: "Podcast Episode Pub Date label"), pubDate.formatted(.dateOnly)))
        }

        if let link = link {
            metadata.append((String(localized: "metadata_podcast_episode_link_label", table: "Item", comment: "Podcast Episode Link label"), link))
        }

        return metadata
    }
}

// MARK: - Game Schema
public struct GameSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to Game
    public let origTitle: String?
    public let genre: [String]
    public let developer: [String]
    public let publisher: [String]
    public let releaseDate: String?
    public let releaseDateJP: String?
    public let releaseDateUS: String?
    public let releaseDateEU: String?
    public let websiteUrl: String?
}

extension GameSchema {
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
        if let releaseDate = releaseDate {
            metadata.append(releaseDate)
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !genre.isEmpty {
            metadata.append((String(localized: "metadata_game_genre_label", table: "Item", comment: "Game Genre label"), genre.joined(separator: metadataArraySeparator)))
        }
        if !developer.isEmpty {
            metadata.append((String(localized: "metadata_game_developer_label", table: "Item", comment: "Game Developer label"), developer.joined(separator: metadataArraySeparator)))
        }
        if !publisher.isEmpty {
            metadata.append((String(localized: "metadata_game_publisher_label", table: "Item", comment: "Game Publisher label"), publisher.joined(separator: metadataArraySeparator)))
        }
        if let releaseDate = releaseDate {
            metadata.append((String(localized: "metadata_game_release_date_label", table: "Item", comment: "Game Release Date label"), releaseDate))
        }
        return metadata
    }
}

// MARK: - Performance Schema
public struct PerformanceSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to Performance
    public let origTitle: String?
    public let otherTitle: [String]?
    public let genre: [String]
    public let language: [String]
    public let openingDate: String?
    public let closingDate: String?
    public let director: [String]
    public let playwright: [String]
    public let origCreator: [String]
    public let composer: [String]
    public let choreographer: [String]
    public let performer: [String]
    public let actor: [CrewMemberSchema]
    public let crew: [CrewMemberSchema]
    public let officialSite: String?
}

extension PerformanceSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if !genre.isEmpty {
            metadata.append(genre.joined(separator: metadataArraySeparator))
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !genre.isEmpty {
            metadata.append((String(localized: "metadata_performance_genre_label", table: "Item", comment: "Performance Genre label"), genre.joined(separator: metadataArraySeparator)))
        }
        if !language.isEmpty {
            metadata.append((String(localized: "metadata_performance_language_label", table: "Item", comment: "Performance Language label"), language.joined(separator: metadataArraySeparator)))
        }
        if let openingDate = openingDate {
            metadata.append((String(localized: "metadata_performance_opening_date_label", table: "Item", comment: "Performance Opening Date label"), openingDate))
        }
        if let closingDate = closingDate {
            metadata.append((String(localized: "metadata_performance_closing_date_label", table: "Item", comment: "Performance Closing Date label"), closingDate))
        }
        if !director.isEmpty {
            metadata.append((String(localized: "metadata_performance_director_label", table: "Item", comment: "Performance Director label"), director.joined(separator: metadataArraySeparator)))
        }
        if !playwright.isEmpty {
            metadata.append((String(localized: "metadata_performance_playwright_label", table: "Item", comment: "Performance Playwright label"), playwright.joined(separator: metadataArraySeparator)))
        }
        if !origCreator.isEmpty {
            metadata.append((String(localized: "metadata_performance_orig_creator_label", table: "Item", comment: "Performance Orig Creator label"), origCreator.joined(separator: metadataArraySeparator)))
        }
        if !composer.isEmpty {
            metadata.append((String(localized: "metadata_performance_composer_label", table: "Item", comment: "Performance Composer label"), composer.joined(separator: metadataArraySeparator)))
        }
        if !choreographer.isEmpty {
            metadata.append((String(localized: "metadata_performance_choreographer_label", table: "Item", comment: "Performance Choreographer label"), choreographer.joined(separator: metadataArraySeparator)))
        }
        if !performer.isEmpty {
            metadata.append((String(localized: "metadata_performance_performer_label", table: "Item", comment: "Performance Performer label"), performer.joined(separator: metadataArraySeparator)))
        }
        if !actor.isEmpty {
            metadata.append((String(localized: "metadata_performance_actor_label", table: "Item", comment: "Performance Actor label"), actor.map { $0.name }.joined(separator: metadataArraySeparator)))
        }
        if !crew.isEmpty {
            metadata.append((String(localized: "metadata_performance_crew_label", table: "Item", comment: "Performance Crew label"), crew.map { $0.name }.joined(separator: metadataArraySeparator)))
        }
        if let officialSite = officialSite {
            metadata.append((String(localized: "metadata_performance_official_site_label", table: "Item", comment: "Performance Official Site label"), officialSite))
        }
        return metadata
    }
}

// MARK: - Performance Production Schema
public struct PerformanceProductionSchema: ItemProtocol {
    public let id: ItemID
    public let type: ItemType
    public let uuid: ItemUUID
    public let url: String
    public let apiUrl: String
    public let category: ItemCategory
    public let parentUuid: ItemUUID?
    public let displayTitle: String?
    public let externalResources: [ItemExternalResourceSchema]?
    public let title: String?
    public let description: String?
    public let localizedTitle: [LocalizedTitleSchema]?
    public let localizedDescription: [LocalizedTitleSchema]?
    public let coverImageUrl: URL?
    public let rating: Double?
    public let ratingCount: Int?
    public let ratingDistribution: [Int]?
    @available(*, deprecated, message: "Brief is deprecated, use description instead.")
    public let brief: String?

    // Additional properties specific to Performance Production
    public let origTitle: String?
    public let otherTitle: [String]?
    public let language: [String]
    public let openingDate: String?
    public let closingDate: String?
    public let director: [String]
    public let playwright: [String]
    public let origCreator: [String]
    public let composer: [String]
    public let choreographer: [String]
    public let performer: [String]
    public let actor: [CrewMemberSchema]
    public let crew: [CrewMemberSchema]
    public let officialSite: String?
}

extension PerformanceProductionSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

        if !language.isEmpty {
            metadata.append(language.joined(separator: metadataArraySeparator))
        }
        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !language.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_language_label", table: "Item", comment: "Performance Production Language label"), language.joined(separator: metadataArraySeparator)))
        }
        if let openingDate = openingDate {
            metadata.append((String(localized: "metadata_performance_production_opening_date_label", table: "Item", comment: "Performance Production Opening Date label"), openingDate))
        }
        if let closingDate = closingDate {
            metadata.append((String(localized: "metadata_performance_production_closing_date_label", table: "Item", comment: "Performance Production Closing Date label"), closingDate))
        }
        if !director.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_director_label", table: "Item", comment: "Performance Production Director label"), director.joined(separator: metadataArraySeparator)))
        }
        if !playwright.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_playwright_label", table: "Item", comment: "Performance Production Playwright label"), playwright.joined(separator: metadataArraySeparator)))
        }
        if !origCreator.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_orig_creator_label", table: "Item", comment: "Performance Production Orig Creator label"), origCreator.joined(separator: metadataArraySeparator)))
        }
        if !composer.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_composer_label", table: "Item", comment: "Performance Production Composer label"), composer.joined(separator: metadataArraySeparator)))
        }
        if !choreographer.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_choreographer_label", table: "Item", comment: "Performance Production Choreographer label"), choreographer.joined(separator: metadataArraySeparator)))
        }
        if !performer.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_performer_label", table: "Item", comment: "Performance Production Performer label"), performer.joined(separator: metadataArraySeparator)))
        }
        if !actor.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_actor_label", table: "Item", comment: "Performance Production Actor label"), actor.map { $0.name }.joined(separator: metadataArraySeparator)))
        }
        if !crew.isEmpty {
            metadata.append((String(localized: "metadata_performance_production_crew_label", table: "Item", comment: "Performance Production Crew label"), crew.map { $0.name }.joined(separator: metadataArraySeparator)))
        }
        if let officialSite = officialSite {
            metadata.append((String(localized: "metadata_performance_production_official_site_label", table: "Item", comment: "Performance Production Official Site label"), officialSite))
        }
        return metadata
    }
}

