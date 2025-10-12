//
//  Collection+ItemPaged.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension Collection {
    /// Paged response wrapper for collection items.
    public struct ItemPaged: Codable, Equatable, Hashable, Sendable {
        /// Page data consisting of items within a collection.
        public let data: [Collection.Item]
        /// Total number of pages available.
        public let pages: Int
        /// Total number of items across all pages.
        public let total: Int
    }
}
