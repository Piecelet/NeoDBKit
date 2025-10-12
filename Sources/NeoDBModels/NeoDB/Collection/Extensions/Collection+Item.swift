//
//  Untitled.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension Collection {
    /// An item entry inside a collection, with an optional user note.
    public struct Item: Codable, Equatable, Hashable, Identifiable, Sendable {
        /// The referenced library item.
        public let item: ItemSchema
        /// User-provided note attached to the item within the collection.
        public let note: String

        /// Stable identifier composed from the item and note.
        public var id: String { item.id + note }
    }
}
