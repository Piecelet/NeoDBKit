//
//  NoteAttributes.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public enum NoteAttributes {
    /// Unique identifier of a note.
    /// Example: "7W5V5e3uEgtpBO2rbkWGNZ"
    public typealias UUID = String

    /// Associated federated post identifier for a note.
    /// Example: 500152287382021080
    public typealias PostID = Int

    /// Whether the note content is marked as sensitive.
    public typealias Sensitive = Bool
}
