//
//  CollectionIn+Item.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension CollectionInSchema {
    /// Payload for adding an item to a collection.
    public struct Item: Codable, Equatable, Hashable, Identifiable, Sendable {
        /// The item to add to the collection.
        public let item: ItemSchema
        /// Optional note to store alongside the item in the collection.
        public let note: String

        /// Ephemeral identifier for UI usage only.
        public var id: String { UUID().uuidString }
    }
}
