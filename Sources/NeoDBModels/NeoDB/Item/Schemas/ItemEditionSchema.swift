//
//  ItemEditionSchema.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

fileprivate let metadataArraySeparator = " "

// MARK: - Edition Schema
public struct ItemEditionSchema: ItemProtocol {
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

    // Additional properties specific to Edition
    public var subtitle: String? = nil
    public var origTitle: String? = nil
    public var author: [String] = []
    public var translator: [String] = []
    public var language: [ItemLocalizedText.KnownLanguage] = []
    public var pubHouse: String? = nil
    public var pubYear: Int? = nil
    public var pubMonth: Int? = nil
    public var binding: String? = nil
    public var price: String? = nil
    public var pages: String? = nil
    public var pagesInt: Int? {
        guard let pages else { return nil }
        return Int(pages.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    public var series: String? = nil
    public var imprint: String? = nil
    public var isbn: String? = nil

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(ItemID.self, forKey: .id)
        uuid = try container.decode(ItemUUID.self, forKey: .uuid)
        url = try container.decode(ItemURL.self, forKey: .url)
        apiUrl = try container.decode(ItemApiURL.self, forKey: .apiUrl)
        type = try container.decode(ItemType.self, forKey: .type)
        category = try container.decode(ItemCategory.self, forKey: .category)
        parentUuid = try container.decodeIfPresent(ItemUUID.self, forKey: .parentUuid)
        displayTitle = try container.decodeIfPresent(String.self, forKey: .displayTitle)
        externalResources = try container.decodeIfPresent([ItemExternalResourceSchema].self, forKey: .externalResources)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        localizedTitle = try container.decodeIfPresent([ItemLocalizedText].self, forKey: .localizedTitle)
        localizedDescription = try container.decodeIfPresent([ItemLocalizedText].self, forKey: .localizedDescription)
        coverImageUrl = try container.decodeIfPresent(URL.self, forKey: .coverImageUrl)
        rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        ratingCount = try container.decodeIfPresent(Int.self, forKey: .ratingCount)
        ratingDistribution = try container.decodeIfPresent([Int].self, forKey: .ratingDistribution)
        tags = try container.decodeIfPresent([String].self, forKey: .tags)
        brief = try container.decodeIfPresent(String.self, forKey: .brief)

        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        origTitle = try container.decodeIfPresent(String.self, forKey: .origTitle)
        author = try container.decodeIfPresent([String].self, forKey: .author) ?? []
        translator = try container.decodeIfPresent([String].self, forKey: .translator) ?? []
        language = try container.decodeIfPresent([ItemLocalizedText.KnownLanguage].self, forKey: .language) ?? []
        pubHouse = try container.decodeIfPresent(String.self, forKey: .pubHouse)
        pubYear = try container.decodeIfPresent(Int.self, forKey: .pubYear)
        pubMonth = try container.decodeIfPresent(Int.self, forKey: .pubMonth)
        binding = try container.decodeIfPresent(String.self, forKey: .binding)
        price = try container.decodeIfPresent(String.self, forKey: .price)
        pages = (try? container.decodeIfPresent(String.self, forKey: .pages)) ?? (try? container.decodeIfPresent(Int.self, forKey: .pages).map(String.init))
        series = try container.decodeIfPresent(String.self, forKey: .series)
        imprint = try container.decodeIfPresent(String.self, forKey: .imprint)
        isbn = try container.decodeIfPresent(String.self, forKey: .isbn)
    }
}

// MARK: - Localization
extension ItemEditionSchema {
    public enum LocalizableMetadata: String, CaseIterable {
        case title
        case description
        case type
        case category

        // Additional properties specific to Edition
        case author
        case translator
        case language
        case pubDate
        case pubHouse
        case pubYear
        case pubMonth
        case binding
        case price
        case pages
        case series
        case imprint
        case isbn

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

            case .author:
                return String(localized: "neodb.item.schema.edition.metadata.author.label", defaultValue: "Author", bundle: .module, comment: "Item Edition Author")
            case .translator:
                return String(localized: "neodb.item.schema.edition.metadata.translator.label", defaultValue: "Translator", bundle: .module, comment: "Item Edition Translator")
            case .language:
                return String(localized: "neodb.item.schema.edition.metadata.language.label", defaultValue: "Language", bundle: .module, comment: "Item Edition Language")
            case .pubDate:
                return String(localized: "neodb.item.schema.edition.metadata.pubdate.label", defaultValue: "Publication Date", bundle: .module, comment: "Item Edition Publication Date")
            case .pubHouse:
                return String(localized: "neodb.item.schema.edition.metadata.pubhouse.label", defaultValue: "Publisher", bundle: .module, comment: "Item Edition Publisher")
            case .pubYear:
                return String(localized: "neodb.item.schema.edition.metadata.pubyear.label", defaultValue: "Pub Year", bundle: .module, comment: "Item Edition Publication Year")
            case .pubMonth:
                return String(localized: "neodb.item.schema.edition.metadata.pubmonth.label", defaultValue: "Pub Month", bundle: .module, comment: "Item Edition Publication Month")
            case .binding:
                return String(localized: "neodb.item.schema.edition.metadata.binding.label", defaultValue: "Binding", bundle: .module, comment: "Item Edition Binding")
            case .price:
                return String(localized: "neodb.item.schema.edition.metadata.price.label", defaultValue: "Price", bundle: .module, comment: "Item Edition Price")
            case .pages:
                return String(localized: "neodb.item.schema.edition.metadata.pages.label", defaultValue: "Number of Pages", bundle: .module, comment: "Item Edition Pages")
            case .series:
                return String(localized: "neodb.item.schema.edition.metadata.series.label", defaultValue: "Series", bundle: .module, comment: "Item Edition Series")
            case .imprint:
                return String(localized: "neodb.item.schema.edition.metadata.imprint.label", defaultValue: "Imprint", bundle: .module, comment: "Item Edition Imprint")
            case .isbn:
                return String(localized: "neodb.item.schema.edition.metadata.isbn.label", defaultValue: "ISBN", bundle: .module, comment: "Item Edition ISBN")
            }
        }
    }
}

// MARK: - ItemEditionSchema Metadata
extension ItemEditionSchema {
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
        if let pagesInt = pagesInt {
            metadata.append(String(format: String(localized: "metadata_book_pages_format", table: "Item", comment: "Book Pages format"), pagesInt))
        } else if let pages = pages?.trimmingCharacters(in: .whitespacesAndNewlines), !pages.isEmpty {
            metadata.append(pages)
        }

        return metadata
    }

    public var allMetadata: [(String, String)] {
        var metadata: [(String, String)] = []

        if !author.isEmpty {
            metadata.append((LocalizableMetadata.author.displayName, author.joined(separator: metadataArraySeparator)))
        }
        if !translator.isEmpty {
            metadata.append((LocalizableMetadata.translator.displayName, translator.joined(separator: metadataArraySeparator)))
        }
        
        if !language.isEmpty {
            let languageDisplayNames = language.compactMap { $0.displayNameWithoutUnknown }
            if !languageDisplayNames.isEmpty {
                metadata.append((LocalizableMetadata.language.displayName, languageDisplayNames.joined(separator: metadataArraySeparator)))
            }
        }
        if let pubHouse = pubHouse {
            metadata.append((LocalizableMetadata.pubHouse.displayName, pubHouse))
        }
        if let pubYear = pubYear {
            metadata.append((LocalizableMetadata.pubYear.displayName, String(pubYear)))
        }
        if let pubMonth = pubMonth {
            metadata.append((LocalizableMetadata.pubMonth.displayName, String(pubMonth)))
        }
        if let binding = binding {
            metadata.append((LocalizableMetadata.binding.displayName, binding))
        }
        if let price = price {
            metadata.append((LocalizableMetadata.price.displayName, price))
        }
        if let pagesInt = pagesInt {
            metadata.append((LocalizableMetadata.pages.displayName, String(pagesInt)))
        } else if let pages = pages?.trimmingCharacters(in: .whitespacesAndNewlines), !pages.isEmpty {
            metadata.append((LocalizableMetadata.pages.displayName, pages))
        }
        if let series = series {
            metadata.append((LocalizableMetadata.series.displayName, series))
        }
        if let imprint = imprint {
            metadata.append((LocalizableMetadata.imprint.displayName, imprint))
        }
        if let isbn = isbn {
            metadata.append((LocalizableMetadata.isbn.displayName, isbn))
        }
        return metadata
    }
}
