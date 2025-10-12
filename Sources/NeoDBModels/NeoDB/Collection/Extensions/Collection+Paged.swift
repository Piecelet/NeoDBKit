//
//  CollectionPaged.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension Collection {
    /// Paged response wrapper for collections.
    public struct Paged: Codable, Equatable, Hashable, Sendable {
        /// Page data consisting of `Collection` entries.
        public let data: [Collection]
        /// Total number of pages available.
        public let pages: Int
        /// Total number of collections across all pages.
        public let count: Int
    }
}
