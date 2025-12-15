//
//  Mark+Paged.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/3/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension MarkSchema {
    /// Paged response wrapper for notes.
    public struct Paged: Codable, Equatable, Hashable, Sendable {
        /// Page data consisting of `Note` entries.
        public let data: [MarkSchema]
        /// Total number of pages available.
        public let pages: Int
        /// Total number of notes across all pages.
        public let count: Int

        public init(
            data: [MarkSchema],
            pages: Int,
            count: Int
        ) {
            self.data = data
            self.pages = pages
            self.count = count
        }
    }
}

extension MarkSchema.Paged {
    public static var placeholders: MarkSchema.Paged {
        .init(
            data: [
                MarkSchema.placeholder,
                MarkSchema.placeholder,
                MarkSchema.placeholder,
                MarkSchema.placeholder,
                MarkSchema.placeholder,
                MarkSchema.placeholder,
                MarkSchema.placeholder,
                MarkSchema.placeholder,
                MarkSchema.placeholder,
                MarkSchema.placeholder,
            ],
            pages: 1,
            count: 1
        )
    }
}
