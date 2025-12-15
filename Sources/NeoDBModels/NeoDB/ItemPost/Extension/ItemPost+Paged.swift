//
//  PaginatedPostList.swift
//  Live Capture
//
//  Created by 甜檸Citron(lcandy2) on 1/30/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension ItemPost {
    public struct Paged: Codable, Hashable, Sendable, Equatable {
        public let data: [NeoDBPost]
        public let pages: Int
        public let count: Int
    }
}
