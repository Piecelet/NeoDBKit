//
//  ShelfType.swift
//  NeoDBKit
//
//  Created by citron on 1/15/25.
//

import Foundation

public enum ShelfType: String, Codable, CaseIterable, Sendable {
    case wishlist
    case progress
    case complete
    case dropped

    public var displayName: String {
        switch self {
        case .wishlist:
            return String(localized: "neodb.mark.shelf_type.wishlist.label", defaultValue: "Wishlist", bundle: .module, comment: "Mark Shelf Type Display Name - Wishlist")
        case .progress:
            return String(localized: "neodb.mark.shelf_type.progress.label", defaultValue: "In Progress", bundle: .module, comment: "Mark Shelf Type Display Name - In Progress")
        case .complete:
            return String(localized: "neodb.mark.shelf_type.complete.label", defaultValue: "Complete", bundle: .module, comment: "Mark Shelf Type Display Name - Complete")
        case .dropped:
            return String(localized: "neodb.mark.shelf_type.dropped.label", defaultValue: "Drop", bundle: .module, comment: "Mark Shelf Type Display Name - Drop")
        }
    }

    public var displayActionState: String {
        switch self {
        case .wishlist:
            return String(localized: "neodb.mark.shelf_type.wishlist.action_state", defaultValue: "Wishlisted", bundle: .module, comment: "Mark Shelf Type Action State - Wishlisted")
        case .progress:
            return String(localized: "neodb.mark.shelf_type.progress.action_state", defaultValue: "In Progress", bundle: .module, comment: "Mark Shelf Type Action State - In progress")
        case .complete:
            return String(localized: "neodb.mark.shelf_type.complete.action_state", defaultValue: "Completed", bundle: .module, comment: "Mark Shelf Type Action State - Completed")
        case .dropped:
            return String(localized: "neodb.mark.shelf_type.dropped.action_state", defaultValue: "Dropped", bundle: .module, comment: "Mark Shelf Type Action State - Dropped")
        }
    }

    public func actionNameFormat(for action: String) -> String {
        String(format: String(localized: "neodb.mark.shelf_type.action_name_format", defaultValue: "Add to \(action)", bundle: .module, comment: "Mark Shelf Type Action State Format - Add to"))
    }

    public var actionName: String {
        actionNameFormat(for: displayName)
    }

    public func actionNameForCategory(_ category: ItemCategory?) -> String {
        actionNameFormat(for: displayNameForCategory(category))
    }

    public func actionStateNameFormat(for actionState: String) -> String {
        String(format: String(localized: "neodb.mark.shelf_type.action_state_name_format", defaultValue: "Added to \(actionState)", bundle: .module, comment: "Mark Shelf Type Action State Name Format - Added to"))
    }

    public var actionStateName: String {
        actionStateNameFormat(for: displayActionState)
    }

    public func actionStateNameForCategory(_ category: ItemCategory?) -> String {
        actionStateNameFormat(for: displayActionStateForCategory(category))
    }

    public func displayNameForCategory(_ category: ItemCategory?) -> String {
        switch (self, category) {
            // - Exclude collection
        case (.wishlist, .collection), (.progress, .collection), (.complete, .collection), (.dropped, .collection):
            return displayName
            // - Wishlist
        case (.wishlist, .movie), (.wishlist, .tv):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.movie_and_tv.label",defaultValue: "Watchlist", bundle: .module, comment: "Neutral noun without action - Wishlist - Movie - Want to watch")
        case (.wishlist, .book):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.book.label", defaultValue: "Readlist", bundle: .module, comment: "Neutral noun without action - Wishlist - Book - Want to read")
        case (.wishlist, .music):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.music.label", defaultValue: "Listenlist", bundle: .module, comment: "Neutral noun without action - Wishlist - Music - Want to listen")
        case (.wishlist, .podcast):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.podcast.label", defaultValue: "Listenlist", bundle: .module, comment: "Neutral noun without action - Wishlist - Podcast - Want to listen")
        case (.wishlist, .game):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.game.label", defaultValue: "Playlist", bundle: .module, comment: "Neutral noun without action - Wishlist - Game - Want to play")
        case (.wishlist, .performance):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.performance.label", defaultValue: "Watchlist", bundle: .module, comment: "Neutral noun without action - Wishlist - Performance - Want to watch")
        // case (.wishlist, .fanfic):
        //     return String(localized: "shelf_type_wishlist_category_fanfic_label", comment: "Neutral noun without action - Wishlist - Fanfic - Want to read")
        // case (.wishlist, .exhibition):
        //     return String(localized: "shelf_type_wishlist_category_exhibition_label", comment: "Neutral noun without action - Wishlist - Exhibition - Want to watch")
        // case (.wishlist, .collection):
        //     return String(localized: "neodb.item.mark.shelf_type.wishlist.category.collection.label", defaultValue: "Collection list", bundle: .module, comment: "Neutral noun without action - Wishlist - Collection - Want to watch")
            // - Progress
        case (.progress, .movie), (.progress, .tv):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.movie_and_tv.label", defaultValue: "Watching", bundle: .module, comment: "Neutral noun without action - Progress - Movie - Watching")
        case (.progress, .book):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.book.label", defaultValue: "Reading", bundle: .module, comment: "Neutral noun without action - Progress - Book - Reading")
        case (.progress, .music):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.music.label", defaultValue: "Listening", bundle: .module, comment: "Neutral noun without action - Progress - Music - Listening")
        case (.progress, .podcast):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.podcast.label", defaultValue: "Listening", bundle: .module, comment: "Neutral noun without action - Progress - Podcast - Listening")
        case (.progress, .game):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.game.label", defaultValue: "Playing", bundle: .module, comment: "Neutral noun without action - Progress - Game - Playing")
        case (.progress, .performance):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.performance.label", defaultValue: "Watching", bundle: .module, comment: "Neutral noun without action - Progress - Performance - Watching")
        // case (.progress, .fanfic):
        //     return String(localized: "shelf_type_progress_category_fanfic_label", comment: "Neutral noun without action - Progress - Fanfic - Reading")
        // case (.progress, .exhibition):
        //     return String(localized: "shelf_type_progress_category_exhibition_label", comment: "Neutral noun without action - Progress - Exhibition - Watching")
        // case (.progress, .collection):
        //     return String(localized: "shelf_type_progress_category_collection_label", comment: "Neutral noun without action - Progress - Collection - Watching")
        case (.complete, .movie), (.complete, .tv):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.movie_and_tv.label", defaultValue: "Watched", bundle: .module, comment: "Neutral noun without action - Complete - Movie - Watched")
        case (.complete, .podcast):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.podcast.label", defaultValue: "Listened", bundle: .module, comment: "Neutral noun without action - Complete - Podcast - Listened")
        case (.complete, .book):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.book.label", defaultValue: "Read", bundle: .module, comment: "Neutral noun without action - Complete - Book - Read")
        case (.complete, .music):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.music.label", defaultValue: "Listened", bundle: .module, comment: "Neutral noun without action - Complete - Music - Listened")
        case (.complete, .game):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.game.label", defaultValue: "Played", bundle: .module, comment: "Neutral noun without action - Complete - Game - Played")
        case (.complete, .performance):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.performance.label", defaultValue: "Watched", bundle: .module, comment: "Neutral noun without action - Complete - Performance - Watched")
        // case (.complete, .fanfic):
        //     return String(localized: "shelf_type_complete_category_fanfic_label", comment: "Neutral noun without action - Complete - Fanfic - Read")
        // case (.complete, .exhibition):
        //     return String(localized: "shelf_type_complete_category_exhibition_label", comment: "Neutral noun without action - Complete - Exhibition - Watched")
        // case (.complete, .collection):
        //     return String(localized: "shelf_type_complete_category_collection_label", comment: "Neutral noun without action - Complete - Collection - Watched")
        case (.dropped, .movie), (.dropped, .tv):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.movie_and_tv.label", defaultValue: "Dropped", bundle: .module, comment: "Neutral noun without action - Dropped - Movie - Dropped")
        case (.dropped, .podcast):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.podcast.label", defaultValue: "Dropped", bundle: .module, comment: "Neutral noun without action - Dropped - Podcast - Dropped")
        case (.dropped, .book):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.book.label", defaultValue: "Dropped", bundle: .module, comment: "Neutral noun without action - Dropped - Book - Dropped")
        case (.dropped, .music):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.music.label", defaultValue: "Dropped", bundle: .module, comment: "Neutral noun without action - Dropped - Music - Dropped")
        case (.dropped, .game):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.game.label", defaultValue: "Dropped", bundle: .module, comment: "Neutral noun without action - Dropped - Game - Dropped")
        case (.dropped, .performance):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.performance.label", defaultValue: "Dropped", bundle: .module, comment: "Neutral noun without action - Dropped - Performance - Dropped")
        // case (.dropped, .fanfic):
        //     return String(localized: "shelf_type_dropped_category_fanfic_label", comment: "Neutral noun without action - Dropped - Fanfic")
        // case (.dropped, .exhibition):
        //     return String(localized: "shelf_type_dropped_category_exhibition_label", comment: "Neutral noun without action - Dropped - Exhibition")
        // case (.dropped, .collection):
        //     return String(localized: "shelf_type_dropped_category_collection_label", comment: "Neutral noun without action - Dropped - Collection")
        default:
            return displayName
        }
    }

    public func displayActionStateForCategory(_ category: ItemCategory?) -> String {
        switch (self, category) {
            // - Exclude collection
        case (.wishlist, .collection), (.progress, .collection), (.complete, .collection), (.dropped, .collection):
            return displayActionState
            // - Wishlist
        case (.wishlist, .movie), (.wishlist, .tv):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.movie_and_tv.action_state", defaultValue: "Watchlisted", bundle: .module, comment: "Action state - Wishlisted - Movie - Wanted to watch")
        case (.wishlist, .book):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.book.action_state", defaultValue: "Readlisted", bundle: .module, comment: "Action state - Wishlisted - Book - Wanted to read")
        case (.wishlist, .music):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.music.action_state", defaultValue: "Listenlisted", bundle: .module, comment: "Action state - Wishlisted - Music - Wanted to listen")
        case (.wishlist, .podcast):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.podcast.action_state", defaultValue: "Listenlisted", bundle: .module, comment: "Action state - Wishlisted - Podcast - Wanted to listen")
        case (.wishlist, .game):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.game.action_state", defaultValue: "Playlisted", bundle: .module, comment: "Action state - Wishlisted - Game - Wanted to play")
        case (.wishlist, .performance):
            return String(localized: "neodb.item.mark.shelf_type.wishlist.category.performance.action_state", defaultValue: "Watchlisted", bundle: .module, comment: "Action state - Wishlisted - Performance - Wanted to watch")
        // case (.wishlist, .fanfic):
        //     return String(localized: "shelf_type_action_wishlist_category_fanfic_label", comment: "Action state - Wishlisted - Fanfic - Wanted to read")
        // case (.wishlist, .exhibition):
        //     return String(localized: "shelf_type_action_wishlist_category_exhibition_label", comment: "Action state - Wishlisted - Exhibition - Wanted to watch")
        // case (.wishlist, .collection):
        //     return String(localized: "shelf_type_action_wishlist_category_collection_label", comment: "Action state - Wishlisted - Collection - Wanted to watch")
        case (.progress, .movie), (.progress, .tv):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.movie_and_tv.action_state", defaultValue: "Watching", bundle: .module, comment: "Action state - Progress - Movie - Watching")
        case (.progress, .book):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.book.action_state", defaultValue: "Reading", bundle: .module, comment: "Action state - Progress - Book - Reading")
        case (.progress, .music):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.music.action_state", defaultValue: "Listening", bundle: .module, comment: "Action state - Progress - Music - Listening")
        case (.progress, .podcast):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.podcast.action_state", defaultValue: "Listening", bundle: .module, comment: "Action state - Progress - Podcast - Listening")
        case (.progress, .game):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.game.action_state", defaultValue: "Playing", bundle: .module, comment: "Action state - Progress - Game - Playing")
        case (.progress, .performance):
            return String(localized: "neodb.item.mark.shelf_type.progress.category.performance.action_state", defaultValue: "Watching", bundle: .module, comment: "Action state - Progress - Performance - Watching")
        // case (.progress, .fanfic):
        //     return String(localized: "shelf_type_action_progress_category_fanfic_label", comment: "Action state - Progress - Fanfic - Reading")
        // case (.progress, .exhibition):
        //     return String(localized: "shelf_type_action_progress_category_exhibition_label", comment: "Action state - Progress - Exhibition - Watching")
        // case (.progress, .collection):
        //     return String(localized: "shelf_type_action_progress_category_collection_label", comment: "Action state - Progress - Collection - Watching")
        case (.complete, .movie), (.complete, .tv):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.movie_and_tv.action_state", defaultValue: "Watched", bundle: .module, comment: "Action state - Complete - Movie - Watched")
        case (.complete, .podcast):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.podcast.action_state", defaultValue: "Listened", bundle: .module, comment: "Action state - Complete - Podcast - Watched")
        case (.complete, .book):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.book.action_state", defaultValue: "Read", bundle: .module, comment: "Action state - Complete - Book - Read")
        case (.complete, .music):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.music.action_state", defaultValue: "Listened", bundle: .module, comment: "Action state - Complete - Music - Watched")
        case (.complete, .game):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.game.action_state", defaultValue: "Played", bundle: .module, comment: "Action state - Complete - Game - Watched")
        case (.complete, .performance):
            return String(localized: "neodb.item.mark.shelf_type.complete.category.performance.action_state", defaultValue: "Watched", bundle: .module, comment: "Action state - Complete - Performance - Watched")
        // case (.complete, .fanfic):
        //     return String(localized: "shelf_type_action_complete_category_fanfic_label", comment: "Action state - Complete - Fanfic - Read")
        // case (.complete, .exhibition):
        //     return String(localized: "shelf_type_action_complete_category_exhibition_label", comment: "Action state - Complete - Exhibition - Watched")
        // case (.complete, .collection):
        //     return String(localized: "shelf_type_action_complete_category_collection_label", comment: "Action state - Complete - Collection - Watched")
        case (.dropped, .movie), (.dropped, .tv):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.movie_and_tv.action_state", defaultValue: "Dropped", bundle: .module, comment: "Action state - Dropped - Movie - Dropped")
        case (.dropped, .podcast):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.podcast.action_state", defaultValue: "Dropped", bundle: .module, comment: "Action state - Dropped - Podcast - Dropped")
        case (.dropped, .book):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.book.action_state", defaultValue: "Dropped", bundle: .module, comment: "Action state - Dropped - Book - Dropped")
        case (.dropped, .music):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.music.action_state", defaultValue: "Dropped", bundle: .module, comment: "Action state - Dropped - Music - Dropped")
        case (.dropped, .game):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.game.action_state", defaultValue: "Dropped", bundle: .module, comment: "Action state - Dropped - Game - Dropped")
        case (.dropped, .performance):
            return String(localized: "neodb.item.mark.shelf_type.dropped.category.performance.action_state", defaultValue: "Dropped", bundle: .module, comment: "Action state - Dropped - Performance - Dropped")
        // case (.dropped, .fanfic):
        //     return String(localized: "shelf_type_action_dropped_category_fanfic_label", comment: "Action state - Dropped - Fanfic - Dropped")
        // case (.dropped, .exhibition):
        //     return String(localized: "shelf_type_action_dropped_category_exhibition_label", comment: "Action state - Dropped - Exhibition - Dropped")
        // case (.dropped, .collection):
        //     return String(localized: "shelf_type_action_dropped_category_collection_label", comment: "Action state - Dropped - Collection - Dropped")
        default:
            return displayActionState
        }
    }

    // public var iconName: String {
    //     switch self {
    //     case .wishlist:
    //         return "star"
    //     case .progress:
    //         return "book"
    //     case .complete:
    //         return "checkmark.circle"
    //     case .dropped:
    //         return "xmark.circle"
    //     }
    // }
}
