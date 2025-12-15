//
//  MastodonMarker.swift
//  NeoDB
//
//  Created by 甜檸Citron(lcandy2) on 2/7/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public struct MastodonMarker: Codable, Sendable {
    public struct Content: Codable, Sendable {
        public let lastReadId: String
        public let version: Int
        public let updatedAt: ServerDate
    }

    public let notifications: Content?
    public let home: Content?
}
