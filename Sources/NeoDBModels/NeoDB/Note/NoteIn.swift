//
//  NoteIn.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

/// Payload for creating or updating a note attached to an item.
///
/// Mirrors the editable fields of `Note` used by the API.
public struct NoteIn: NoteProtocol {
    /// Optional note title.
    public var title: String?
    /// Optional plain-text content/body of the note.
    public var content: String?
    /// Whether the note content is marked sensitive.
    public var sensitive: NoteAttributes.Sensitive?
    /// Optional progress type (e.g., reading, watching).
    public var progressType: NoteProgressType?
    /// Optional progress value (e.g., percentage or chapter).
    public var progressValue: String?
    /// Visibility of the note (e.g., public, unlisted, private).
    public var visibility: NeoDBVisibility

    /// Ephemeral identifier for UI usage only.
    public var id: String { UUID().uuidString }

    /// Creates a new note payload.
    /// - Parameters:
    ///   - title: Optional title of the note.
    ///   - content: Optional note content.
    ///   - sensitive: Whether the note is sensitive.
    ///   - progressType: Progress metric type.
    ///   - progressValue: Progress value for the chosen type.
    ///   - visibility: Visibility level when publishing.
    public init(title: String? = nil, content: String? = nil, sensitive: NoteAttributes.Sensitive? = nil, progressType: NoteProgressType? = nil, progressValue: String? = nil, visibility: NeoDBVisibility) {
        self.title = title
        self.content = content
        self.sensitive = sensitive
        self.progressType = progressType
        self.progressValue = progressValue
        self.visibility = visibility
    }
}
