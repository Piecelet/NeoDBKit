//
//  Note+Paged.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension NoteSchema {
    /// Paged response wrapper for notes.
    public struct Paged: Codable, Equatable, Hashable, Sendable {
        /// Page data consisting of `Note` entries.
        public let data: [NoteSchema]
        /// Total number of pages available.
        public let pages: Int
        /// Total number of notes across all pages.
        public let count: Int
    }
}
