//
//  ProgressType.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

/// Types of progress metrics that a note can represent.
public enum NoteProgressType: String, Codable, Equatable, Hashable, Identifiable, Sendable {
    /// Page number (books).
    case page
    /// Chapter identifier (books).
    case chapter
    /// Part or segment of a work.
    case part
    /// Episode number (TV, podcast).
    case episode
    /// Track number (music).
    case track
    /// Cycle or run count (games).
    case cycle
    /// Timestamp (hh:mm:ss) within media.
    case timestamp
    /// Percentage completion.
    case percentage

    /// Stable identifier backing the enum case.
    public var id: String { rawValue }

    /// Returns progress types that make sense for a given item category.
    /// - Parameter category: The item category.
    /// - Returns: Supported progress types for the category.
    public func available(per category: ItemCategory) -> [NoteProgressType] {
        switch category {
        case .book:
            return [.page, .chapter, .percentage]
        case .movie:
            return [.part, .timestamp, .percentage]
        case .tv:
            return [.part, .episode, .percentage]
        case .music:
            return [.track, .timestamp, .percentage]
        case .podcast:
            return [.episode]
        case .game:
            return [.cycle]
        case .performance:
            return [.part, .timestamp, .percentage]
        default:
            return []
        }
    }

    /// Localized display name for the progress type.
    var displayName: String {
        switch self {
        case .page:
            return String(localized: "neodb.note.progress_type.page.label", defaultValue: "Page", bundle: .module, comment: "NeoDB Note Progress Type - Label for page option")
        case .chapter:
            return String(localized: "neodb.note.progress_type.chapter.label", defaultValue: "Chapter", bundle: .module, comment: "NeoDB Note Progress Type - Label for chapter option")
        case .part:
            return String(localized: "neodb.note.progress_type.part.label", defaultValue: "Part", bundle: .module, comment: "NeoDB Note Progress Type - Label for part option")
        case .episode:
            return String(localized: "neodb.note.progress_type.episode.label", defaultValue: "Episode", bundle: .module, comment: "NeoDB Note Progress Type - Label for episode option")
        case .track:
            return String(localized: "neodb.note.progress_type.track.label", defaultValue: "Track", bundle: .module, comment: "NeoDB Note Progress Type - Label for track option")
        case .cycle:
            return String(localized: "neodb.note.progress_type.cycle.label", defaultValue: "Cycle", bundle: .module, comment: "NeoDB Note Progress Type - Label for cycle option")
        case .timestamp:
            return String(localized: "neodb.note.progress_type.timestamp.label", defaultValue: "Timestamp", bundle: .module, comment: "NeoDB Note Progress Type - Label for timestamp option")
        case .percentage:
            return String(localized: "neodb.note.progress_type.percentage.label", defaultValue: "Percentage", bundle: .module, comment: "NeoDB Note Progress Type - Label for percentage option")
        }
    }
}
