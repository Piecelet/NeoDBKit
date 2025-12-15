//
//  Item.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import Foundation

// MARK: - Base Item Protocol
public protocol ItemProtocol: Codable, Decodable, Equatable, Hashable, Identifiable, Sendable {
    var id: ItemID { get }
    var uuid: ItemUUID { get }
    var url: ItemURL { get }
    var apiUrl: ItemApiURL { get }
    var type: ItemType { get }
    var category: ItemCategory { get }
    var parentUuid: ItemUUID? { get }
    var displayTitle: String? { get }
    var externalResources: [ItemExternalResourceSchema]? { get }
    var title: String? { get }
    var description: String? { get }
    var localizedTitle: [ItemLocalizedText]? { get }
    var localizedDescription: [ItemLocalizedText]? { get }
    var coverImageUrl: URL? { get }
    var rating: Double? { get }
    var ratingCount: Int? { get }
    var ratingDistribution: [Int]? { get }
    var tags: [String]? { get }
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
            ratingDistribution: self.ratingDistribution
        )
    }
}

extension ItemProtocol {
    public static func sanitizeAreaValues(_ values: [String]) -> [String] {
        values.map { value in
            var sanitized = value
            sanitized = sanitized.replacingOccurrences(of: "中国台湾省", with: "台湾")
            sanitized = sanitized.replacingOccurrences(of: "中國台灣省", with: "台灣")
            sanitized = sanitized.replacingOccurrences(of: "中国台湾", with: "台湾")
            sanitized = sanitized.replacingOccurrences(of: "中國台灣", with: "台灣")
            sanitized = sanitized.replacingOccurrences(of: "中國臺灣", with: "臺灣")
            sanitized = sanitized.replacingOccurrences(of: "中国香港", with: "香港")
            sanitized = sanitized.replacingOccurrences(of: "中國香港", with: "香港")
            sanitized = sanitized.replacingOccurrences(of: "中国澳门", with: "澳门")
            sanitized = sanitized.replacingOccurrences(of: "中國澳門", with: "澳門")
            sanitized = sanitized.replacingOccurrences(of: "台湾省", with: "台湾")
            sanitized = sanitized.replacingOccurrences(of: "台灣省", with: "台灣")
            sanitized = sanitized.replacingOccurrences(of: "Taiwan, China", with: "Taiwan")
            sanitized = sanitized.replacingOccurrences(of: "Taiwan,China", with: "Taiwan")
            sanitized = sanitized.replacingOccurrences(of: "Hong Kong, China", with: "Hong Kong")
            sanitized = sanitized.replacingOccurrences(of: "Hong Kong,China", with: "Hong Kong")
            sanitized = sanitized.replacingOccurrences(of: "Macau, China", with: "Macau")
            sanitized = sanitized.replacingOccurrences(of: "Macau,China", with: "Macau")
            sanitized = sanitized.replacingOccurrences(of: "TW,CN", with: "TW")
            sanitized = sanitized.replacingOccurrences(of: "TW, CN", with: "TW")
            sanitized = sanitized.replacingOccurrences(of: "TW, China", with: "TW")
            sanitized = sanitized.replacingOccurrences(of: "TW,China", with: "TW")
            sanitized = sanitized.replacingOccurrences(of: "HK,CN", with: "HK")
            sanitized = sanitized.replacingOccurrences(of: "HK, CN", with: "HK")
            sanitized = sanitized.replacingOccurrences(of: "HK, China", with: "HK")
            sanitized = sanitized.replacingOccurrences(of: "HK,China", with: "HK")
            sanitized = sanitized.replacingOccurrences(of: "MO,CN", with: "MO")
            sanitized = sanitized.replacingOccurrences(of: "MO, CN", with: "MO")
            sanitized = sanitized.replacingOccurrences(of: "MO, China", with: "MO")
            sanitized = sanitized.replacingOccurrences(of: "MO,China", with: "MO")
            sanitized = sanitized.replacingOccurrences(of: "Taiwan, Province of China", with: "Taiwan")
            return sanitized
        }
    }
}

// MARK: - Edition Schema
public typealias EditionSchema = ItemEditionSchema

// MARK: - Movie Schema
public typealias MovieSchema = ItemMovieSchema

// MARK: - TV Show Schema
public typealias TVShowSchema = ItemTVShowSchema

// MARK: - Album Schema
public typealias AlbumSchema = ItemAlbumSchema

// MARK: - Podcast Schema
public typealias PodcastSchema = ItemPodcastSchema

// MARK: - Game Schema
public typealias GameSchema = ItemGameSchema

// MARK: - Performance Schema
public typealias PerformanceSchema = ItemPerformanceSchema
