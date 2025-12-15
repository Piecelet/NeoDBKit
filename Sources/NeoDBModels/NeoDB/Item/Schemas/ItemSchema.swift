//
//  ItemSchema.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import Foundation

// MARK: - Base Item Schema
public struct ItemSchema: ItemProtocol {
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

    public init(
        id: ItemID,
        type: ItemType,
        uuid: ItemUUID,
        url: ItemURL = "",
        apiUrl: ItemApiURL = "",
        category: ItemCategory,
        parentUuid: ItemUUID? = nil,
        displayTitle: String? = nil,
        externalResources: [ItemExternalResourceSchema]? = nil,
        title: String? = nil,
        description: String? = nil,
        localizedTitle: [ItemLocalizedText]? = nil,
        localizedDescription: [ItemLocalizedText]? = nil,
        coverImageUrl: URL? = nil,
        rating: Double? = nil,
        ratingCount: Int? = nil,
        ratingDistribution: [Int]? = nil,
        tags: [String]? = nil
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
        self.tags = tags
    }
}

extension ItemSchema {
    public enum LocalizableMetadata: String, Codable, Equatable, Hashable, Sendable {
        case title
        case description
        case type
        case category

        public var displayName: String {
            switch self {
            case .title:
                return String(localized: "neodb.item.schema.common.metadata.title", defaultValue: "Title", bundle: .module, comment: "NeoDB Item Metadata - Title")
            case .description:
                return String(localized: "neodb.item.schema.common.metadata.description", defaultValue: "Description", bundle: .module, comment: "NeoDB Item Metadata - Description")
            case .type:
                return String(localized: "neodb.item.schema.common.metadata.type", defaultValue: "Type", bundle: .module, comment: "NeoDB Item Metadata - Type")
            case .category:
                return String(localized: "neodb.item.schema.common.metadata.category", defaultValue: "Category", bundle: .module, comment: "NeoDB Item Metadata - Category")
            }
        }
    }
}

extension ItemSchema {
    public static var preview: ItemSchema {
        ItemSchema(
            id: "1",
            type: .book,
            uuid: "1",
            url: "/book/1",
            apiUrl: "https://api.example.com/item/1",
            category: .book,
            parentUuid: nil,
            displayTitle: "Sample Item",
            externalResources: nil,
            title: "Sample Item",
            description: "A sample item description",
            localizedTitle: [],
            localizedDescription: [],
            coverImageUrl: nil,
            rating: 4.5,
            ratingCount: 1234,
            ratingDistribution: [20, 30, 50, 0, 0],
        )
    }
}

extension ItemSchema {
    @available(*, deprecated, message: "Use ItemSchema.makeTemporaryItemSchema(id: URL) instead.")
    public static func makeTemporaryItemSchema(uuid: String) -> ItemSchema {
        return ItemSchema.makeTemporaryItemSchema(id: URL(string: "https://unknown.neodb.net/unknown/\(uuid)")!)
    }

    @available(*, deprecated, message: "Use ItemSchema.makeItemSchema(id: ItemID) instead.")
    public static func makeTemporaryItemSchema(id: URL) -> ItemSchema {
        return makeItemSchema(id: ItemID(id))
    }

    public static func makeItemSchema(id: ItemID, title: String? = nil, description: String? = nil, coverImageUrl: URL? = nil, rating: Double? = nil, ratingCount: Int? = nil) -> ItemSchema {
        return ItemSchema(
            id: id,
            type: id.type ?? .unknown,
            uuid: id.uuid,
            url: id.rawURL?.path ?? "",
            apiUrl: "",
            category: id.category ?? .book,
            parentUuid: nil,
            displayTitle: title,
            externalResources: nil,
            title: title,
            description: description,
            localizedTitle: nil,
            localizedDescription: nil,
            coverImageUrl: coverImageUrl,
            rating: rating,
            ratingCount: ratingCount,
            ratingDistribution: nil
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

    public static func makeType(type: ItemType) -> any ItemProtocol.Type {
        if let category = type.category {
            return makeType(category: category)
        }
        return ItemSchema.self
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
            ratingDistribution: nil
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
