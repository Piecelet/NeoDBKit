//
//  NoteProtocol.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

/// Common interface for note-like models.
///
/// Implemented by both `Note` (read model) and `NoteIn` (write model).
/// Exposes only the editable fields shared by both types.
public protocol NoteProtocol: Codable, Equatable, Hashable, Identifiable, Sendable {
    /// Optional note title.
    var title: String? { get set }
    /// Optional plain-text content/body of the note.
    var content: String? { get set }
    /// Whether the note content is marked sensitive.
    var sensitive: Bool? { get set }
    /// Optional progress type (e.g., reading, watching).
    var progressType: NoteProgressType? { get set }
    /// Optional progress value (e.g., percentage or chapter).
    var progressValue: String? { get set }
    /// Visibility of the note (e.g., public, unlisted, private).
    var visibility: NeoDBVisibility { get set }
}
