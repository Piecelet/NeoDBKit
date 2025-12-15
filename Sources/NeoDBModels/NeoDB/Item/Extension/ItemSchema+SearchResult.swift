//
//  Item+Paged.swift
//  NeoDBKit
//
//  Created by citron on 1/15/25.
//

import Foundation

extension ItemSchema {
    public struct SearchResult: Codable {
        public let data: [ItemSchema]
        public let pages: Int
        public let count: Int
    }
}
