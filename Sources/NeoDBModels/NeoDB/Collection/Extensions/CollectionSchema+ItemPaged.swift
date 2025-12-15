//
//  Collection+ItemPaged.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension CollectionSchema {
    /// Paged response wrapper for collection items.
    public struct ItemPaged: Codable, Equatable, Hashable, Sendable {
        /// Page data consisting of items within a collection.
        public let data: [CollectionSchema.Item]
        /// Total number of pages available.
        public let pages: Int
        /// Total number of items across all pages.
        public let count: Int

        public init(data: [CollectionSchema.Item], pages: Int, count: Int) {
            self.data = data
            self.pages = pages
            self.count = count
        }
    }
}

extension CollectionSchema.ItemPaged {
    /// A placeholder instance for testing or preview purposes.
    public static var placeholder: CollectionSchema.ItemPaged {
        return .init(
            data: Array(repeating: .placeholder, count: 20),
            pages: 1,
            count: 20
        )
    }
}