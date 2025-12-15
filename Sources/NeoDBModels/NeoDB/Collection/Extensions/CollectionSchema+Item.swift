//
//  Untitled.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension CollectionSchema {
    /// An item entry inside a collection, with an optional user note.
    public struct Item: Codable, Equatable, Hashable, Identifiable, Sendable {
        /// The referenced library item.
        public let item: any ItemProtocol
        /// User-provided note attached to the item within the collection.
        public let note: String

        /// Stable identifier composed from the item and note.
        public var id: String { item.id.rawValue + note }

        public init(item: any ItemProtocol, note: String) {
            self.item = item
            self.note = note
        }

        enum CodingKeys: String, CodingKey {
            case item
            case note
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let note = try container.decode(String.self, forKey: .note)

            // Step 1: decode as base schema to discover the category.
            let baseItem = try container.decode(ItemSchema.self, forKey: .item)

            // Step 2: decode the original payload into the category-specific schema.
            let itemDecoder = try container.superDecoder(forKey: .item)
            let categoryType = ItemSchema.makeType(category: baseItem.category)

            let typedItem: any ItemProtocol
            do {
                typedItem = try categoryType.init(from: itemDecoder)
            } catch {
                typedItem = baseItem
            }

            self.init(item: typedItem, note: note)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(note, forKey: .note)
            try item.encode(to: container.superEncoder(forKey: .item))
        }

        public static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.item.id == rhs.item.id && lhs.note == rhs.note
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(item.id)
            hasher.combine(note)
        }
    }
}

extension CollectionSchema.Item {
    public static var placeholder: CollectionSchema.Item {
        return .init(
            item: ItemSchema.placeholder,
            note: "AABBCCDDDEEFFGGHHIIJJKKLLMMNNOOPPQQRRSSTTUUVVWWXXYYZZ, I am a placeholder note for this item in the collection. I love NeoDB and Piecelet!"
        )
    }
}
