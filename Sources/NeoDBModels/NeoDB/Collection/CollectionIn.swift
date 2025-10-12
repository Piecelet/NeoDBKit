//
//  CollectionIn.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

/// Payload for creating or updating a collection.
///
/// Mirrors the editable fields of `Collection` used by the API.
public struct CollectionIn: CollectionProtocol {
    /// Short description or summary of the collection.
    public var brief: String
    /// Title of the collection.
    public var title: String
    /// Visibility of the collection (e.g., public, unlisted, private).
    public var visibility: NeoDBVisibility

    /// Ephemeral identifier for UI usage only.
    public var id: String { UUID().uuidString }

    /// Creates a new collection payload.
    /// - Parameters:
    ///   - brief: Short description or summary.
    ///   - title: Collection title.
    ///   - visibility: Visibility level when publishing.
    public init(brief: String, title: String, visibility: NeoDBVisibility) {
        self.brief = brief
        self.title = title
        self.visibility = visibility
    }
}
