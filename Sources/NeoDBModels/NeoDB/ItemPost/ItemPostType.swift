//
//  ItemPostType.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 1/31/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public enum ItemPostType: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
    case comment
    case review
    case collection
    case note
    case mark
    case none
}

extension ItemPostType {
    public var displayNameSingular: String {
        switch self {
        case .comment:
            return String(localized: "neodb.item_post.type.comment.label.singular", defaultValue: "Comment", bundle: .module, comment: "Item Post Type - Label for 'Comment' post type")
        case .review:
            return String(localized: "neodb.item_post.type.review.label.singular", defaultValue: "Review", bundle: .module, comment: "Item Post Type - Label for 'Review' post type")
        case .collection:
            return String(localized: "neodb.item_post.type.collection.label.singular", defaultValue: "Collection", bundle: .module, comment: "Item Post Type - Label for 'Collection' post type")
        case .note:
            return String(localized: "neodb.item_post.type.note.label.singular", defaultValue: "Note", bundle: .module, comment: "Item Post Type - Label for 'Note' post type")
        case .mark:
            return String(localized: "neodb.item_post.type.mark.label.singular", defaultValue: "Mark", bundle: .module, comment: "Item Post Type - Label for 'Mark' post type")
        case .none:
            return String(localized: "neodb.item_post.type.default.label.singular", defaultValue: "Post", bundle: .module, comment: "Item Post Type - Label for 'Post' post type")
        }
    }

    public var displayNamePlural: String {
        switch self {
        case .comment:
            return String(localized: "neodb.item_post.type.comment.label.plural", defaultValue: "Comments", bundle: .module, comment: "Item Post Type - Label for 'Comments' post type")
        case .review:
            return String(localized: "neodb.item_post.type.review.label.plural", defaultValue: "Reviews", bundle: .module, comment: "Item Post Type - Label for 'Reviews' post type")
        case .collection:
            return String(localized: "neodb.item_post.type.collection.label.plural", defaultValue: "Collections", bundle: .module, comment: "Item Post Type - Label for 'Collections' post type")
        case .note:
            return String(localized: "neodb.item_post.type.note.label.plural", defaultValue: "Notes", bundle: .module, comment: "Item Post Type - Label for 'Notes' post type")
        case .mark:
            return String(localized: "neodb.item_post.type.mark.label.plural", defaultValue: "Marks", bundle: .module, comment: "Item Post Type - Label for 'Marks' post type")
        case .none:
            return String(localized: "neodb.item_post.type.default.label.plural", defaultValue: "Posts", bundle: .module, comment: "Item Post Type - Label for 'Posts' post type")
        }
    }

    public var emptyText: String {
        switch self {
        case .comment:
            return String(localized: "neodb.item_post.type.comment.empty.label", defaultValue: "No comments", table: "Item")
        case .review:
            return String(localized: "neodb.item_post.type.review.empty.label", defaultValue: "No reviews", table: "Item")
        case .collection:
            return String(localized: "neodb.item_post.type.collection.empty.label", defaultValue: "No collections", table: "Item")
        case .note:
            return String(localized: "neodb.item_post.type.note.empty.label", defaultValue: "No notes", table: "Item")
        case .mark:
            return String(localized: "neodb.item_post.type.mark.empty.label", defaultValue: "No marks", table: "Item")
        case .none:
            return String(localized: "neodb.item_post.type.default.empty.label", defaultValue: "No posts", table: "Item")
        }
    }
}
