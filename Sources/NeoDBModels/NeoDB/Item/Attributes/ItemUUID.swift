//
//  ItemUUID.swift
//  NeoDB
//
//  Created by 甜檸Citron(lcandy2) on 9/18/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

// ItemUUID is the canonical, normalized NeoDB item identifier (usually 22 chars), unlike ItemID which may be a full URL.
// Example UUID: "abcdefghijk1234567890z" (22 chars, no slashes).
// Use ItemUUID for storage/lookup keys; keep ItemID when you need the original URL form.
public typealias ItemUUID = String

public extension ItemUUID {
    /// Expected NeoDB id length (currently 22).
    private static let neodbUUIDLength: Int = 22
    private static let neodbUUIDAllowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

    /// Returns true if this looks like a normalized NeoDB item UUID (no slashes, length matches ItemID.neodbIdLength).
    // var isLikelyItemUUID: Bool {
    //     !contains("/") && count == Self.neodbUUIDLength
    // }

    var isLikelyValid: Bool {
        return Self.testIsLikelyValid(self)
    }

    /// Fixed-length validation for NeoDB item ids.
    /// ItemUUID must be exactly 22 characters containing only a-z, A-Z, 0-9.
    static func testIsLikelyValid(_ uuid: ItemUUID) -> Bool {
        guard uuid.count == Self.neodbUUIDLength else { return false }
        let allowedSet = Self.neodbUUIDAllowedCharacters
        return uuid.unicodeScalars.allSatisfy { allowedSet.contains($0) }
    }

    // /// Converts this UUID into a URL-style ItemID using instance + item category.
    // /// Example: uuid.toItemID(instance: "neodb.social", category: .book) -> "https://neodb.social/book/<uuid>"
    // func toItemID(instance: String, category: ItemCategory) -> ItemID {
    //     let categoryPath = category.urlPath
    //     let trimmed = instance.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    //     return "https://\(trimmed)/\(categoryPath)/\(self)"
    // }

    // /// Overload for ItemType convenience; falls back to type rawValue if category is unknown.
    // func toItemID(instance: String, type: ItemType) -> ItemID {
    //     if let cat = type.category {
    //         return toItemID(instance: instance, category: cat)
    //     }
    //     let categoryPath = type.rawValue.lowercased()
    //     let trimmed = instance.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    //     return "https://\(trimmed)/\(categoryPath)/\(self)"
    // }
}
