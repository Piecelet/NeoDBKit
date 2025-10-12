//
//  CollectionProtocol.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

/// Common interface for collection-like models.
///
/// Implemented by both `Collection` (read model) and `CollectionIn`
/// (write model). Exposes the editable fields shared by both types.
public protocol CollectionProtocol: Codable, Equatable, Hashable, Identifiable, Sendable {
    /// Short description or summary of the collection.
    var brief: String { get set }
    /// Title of the collection.
    var title: String { get set }
    /// Visibility of the collection (e.g., public, unlisted, private).
    var visibility: NeoDBVisibility { get set }

    // Properties specific to `Collection` are intentionally omitted here
    // and documented on `Collection` directly (e.g., `uuid`, `url`, etc.).
}
