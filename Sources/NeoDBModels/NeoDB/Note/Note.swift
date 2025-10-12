//
//  Note.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

/// Represents a user-authored note attached to an item in NeoDB.
///
/// Notes may include progress tracking fields and can be shared with
/// different visibilities depending on user preference.
public struct Note: NoteProtocol {
    /// Unique identifier of the note.
    public var uuid: NoteAttributes.UUID
    /// Associated federated post identifier, if applicable.
    public var postId: NoteAttributes.PostID
    /// The item this note is attached to.
    public var item: ItemSchema
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
    /// Creation timestamp on the server.
    public var createdTime: ServerDate

    /// Stable identifier for UI usage (aliases `uuid`).
    public var id: NoteAttributes.UUID { uuid }
}
