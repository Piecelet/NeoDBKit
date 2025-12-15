//
//  ItemPerformanceSchema.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

fileprivate let metadataArraySeparator = " "

// MARK: - Performance Schema
public struct ItemPerformanceSchema: ItemProtocol {
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

    // Additional properties specific to both Performance and Performance Production
    public var origTitle: String? = nil
    // public let otherTitle: [String]?
    public var genre: [String] = []
    public var language: [ItemLocalizedText.KnownLanguage] = []
    public var openingDate: String? = nil
    public var closingDate: String? = nil
    public var director: [String] = []
    public var playwright: [String] = []
    public var origCreator: [String] = []
    public var composer: [String] = []
    public var choreographer: [String] = []
    public var performer: [String] = []
    public var actor: [ItemPerformanceSchema.CrewMember] = []
    public var crew: [ItemPerformanceSchema.CrewMember] = []
    public var officialSite: String? = nil
}

extension ItemPerformanceSchema {
    public enum LocalizableMetadata: CaseIterable {
        case title
        case description
        case type
        case category
        
        case origTitle
        case genre
        case language
        case openingDate
        case closingDate
        case director
        case playwright
        case origCreator
        case composer
        case choreographer
        case performer
        case actor
        case crew
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
            case .origTitle:
                return String(localized: "neodb.item.schema.performance.metadata.orig_title.label", defaultValue: "Original Title", bundle: .module, comment: "Performance Original Title label")
            case .genre:
                return String(localized: "neodb.item.schema.performance.metadata.genre.label", defaultValue: "Genre", bundle: .module, comment: "Performance Genre label")
            case .language:
                return String(localized: "neodb.item.schema.performance.metadata.language.label", defaultValue: "Language", bundle: .module, comment: "Performance Language label")
            case .openingDate:
                return String(localized: "neodb.item.schema.performance.metadata.opening_date.label", defaultValue: "Opening Date", bundle: .module, comment: "Performance Opening Date label")
            case .closingDate:
                return String(localized: "neodb.item.schema.performance.metadata.closing_date.label", defaultValue: "Closing Date", bundle: .module, comment: "Performance Closing Date label")
            case .director:
                return String(localized: "neodb.item.schema.performance.metadata.director.label", defaultValue: "Director", bundle: .module, comment: "Performance Director label")
            case .playwright:
                return String(localized: "neodb.item.schema.performance.metadata.playwright.label", defaultValue: "Playwright", bundle: .module, comment: "Performance Playwright label")
            case .origCreator:
                return String(localized: "neodb.item.schema.performance.metadata.orig_creator.label", defaultValue: "Original Creator", bundle: .module, comment: "Performance Original Creator label")
            case .composer:
                return String(localized: "neodb.item.schema.performance.metadata.composer.label", defaultValue: "Composer", bundle: .module, comment: "Performance Composer label")
            case .choreographer:
                return String(localized: "neodb.item.schema.performance.metadata.choreographer.label", defaultValue: "Choreographer", bundle: .module, comment: "Performance Choreographer label")
            case .performer:
                return String(localized: "neodb.item.schema.performance.metadata.performer.label", defaultValue: "Performer", bundle: .module, comment: "Performance Performer label")
            case .actor:
                return String(localized: "neodb.item.schema.performance.metadata.actor.label", defaultValue: "Actor", bundle: .module, comment: "Performance Actor label")
            case .crew:
                return String(localized: "neodb.item.schema.performance.metadata.crew.label", defaultValue: "Crew", bundle: .module, comment: "Performance Crew label")
            case .officialSite:
                return String(localized: "neodb.item.schema.performance.metadata.official_site.label", defaultValue: "Official Site", bundle: .module, comment: "Performance Official Site label")
            }
        }
    }
}

extension PerformanceSchema {
    public var keyMetadata: [String] {
        var metadata: [String] = []

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

        if !playwright.isEmpty {
            metadata.append(playwright.prefix(2).joined(separator: metadataArraySeparator))
        }

        if !origCreator.isEmpty {
            metadata.append(origCreator.prefix(2).joined(separator: metadataArraySeparator))
        }

        if !actor.isEmpty {
            metadata.append(actor.prefix(5).map { $0.name }.joined(separator: metadataArraySeparator))
        }

        if !crew.isEmpty {
            metadata.append(crew.prefix(3).map { $0.name }.joined(separator: metadataArraySeparator))
        }

        if !composer.isEmpty {
            metadata.append(composer.prefix(2).joined(separator: metadataArraySeparator))
        }

        if !choreographer.isEmpty {
            metadata.append(choreographer.prefix(2).joined(separator: metadataArraySeparator))
        }

        if let openingDate = openingDate {
            metadata.append(openingDate)
        }

        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !genre.isEmpty {
            metadata.append((LocalizableMetadata.genre.displayName, genre.joined(separator: metadataArraySeparator)))
        }
        if !language.isEmpty {
            let languageDisplayNames = language.compactMap { $0.displayNameWithoutUnknown }
            if !languageDisplayNames.isEmpty {
                metadata.append((LocalizableMetadata.language.displayName, languageDisplayNames.joined(separator: metadataArraySeparator)))
            }
        }
        if let openingDate = openingDate {
            metadata.append((LocalizableMetadata.openingDate.displayName, openingDate))
        }
        if let closingDate = closingDate {
            metadata.append((LocalizableMetadata.closingDate.displayName, closingDate))
        }
        if !director.isEmpty {
            metadata.append((LocalizableMetadata.director.displayName, director.joined(separator: metadataArraySeparator)))
        }
        if !playwright.isEmpty {
            metadata.append((LocalizableMetadata.playwright.displayName, playwright.joined(separator: metadataArraySeparator)))
        }
        if !origCreator.isEmpty {
            metadata.append((LocalizableMetadata.origCreator.displayName, origCreator.joined(separator: metadataArraySeparator)))
        }
        if !composer.isEmpty {
            metadata.append((LocalizableMetadata.composer.displayName, composer.joined(separator: metadataArraySeparator)))
        }
        if !choreographer.isEmpty {
            metadata.append((LocalizableMetadata.choreographer.displayName, choreographer.joined(separator: metadataArraySeparator)))
        }
        if !performer.isEmpty {
            metadata.append((LocalizableMetadata.performer.displayName, performer.joined(separator: metadataArraySeparator)))
        }
        if !actor.isEmpty {
            metadata.append((LocalizableMetadata.actor.displayName, actor.map { $0.name }.joined(separator: metadataArraySeparator)))
        }
        if !crew.isEmpty {
            metadata.append((LocalizableMetadata.crew.displayName, crew.map { $0.name }.joined(separator: metadataArraySeparator)))
        }
        if let officialSite = officialSite {
            metadata.append((LocalizableMetadata.officialSite.displayName, officialSite))
        }
        return metadata
    }
}

// MARK: - Performance Production Schema
//public struct PerformanceProductionSchema: ItemProtocol {
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
//    // Additional properties specific to Performance Production
//    public let origTitle: String?
//    public let otherTitle: [String]?
//    public let language: [String]
//    public let openingDate: String?
//    public let closingDate: String?
//    public let director: [String]
//    public let playwright: [String]
//    public let origCreator: [String]
//    public let composer: [String]
//    public let choreographer: [String]
//    public let performer: [String]
//    public let actor: [CrewMemberSchema]
//    public let crew: [CrewMemberSchema]
//    public let officialSite: String?
//}
