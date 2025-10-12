//
//  ItemID.swift
//  NeoDB
//
//  Created by Codex on 9/18/25.
//

import Foundation

// Needed for allowed first path segment validation
// (Uses ItemCategory.urlPath to normalize special cases like tv/podcast)
// This file is in the same target, so no extra module import is necessary.
// If compilation complains, consider moving the logic to a helper in the URL layer.
// However, current project setup allows referencing ItemCategory directly.
//
// Note: Keep this extension lightweight and pure — no I/O.
// It is OK for callers to use the boolean/optional-returning APIs.

// ItemID is a lightweight alias for String used for item identifiers.
// Using a typealias keeps source compatibility while giving us a semantic name.
public typealias ItemID = String

public extension ItemID {
    /// Extracts the UUID portion from an item ID string.
    /// - Returns: The last non-empty path component, or the original string if no separator is found.
    /// Examples:
    /// - "https://neodb.social/book/abc123" -> "abc123"
    /// - "/tv/season/xyz" -> "xyz"
    /// - "plain-uuid" -> "plain-uuid"
    var toUUID: String {
        // Prefer URL parsing to handle queries and fragments
        if let url = URL(string: self) {
            let path = url.path
            if let last = path.split(separator: "/").last {
                return String(last)
            }
        }
        // Fallback: strip query, then split by '/'
        let head = self.split(separator: "?", maxSplits: 1).first.map(String.init) ?? self
        return head.components(separatedBy: "/").last ?? head
    }

    /// Attempts to extract the instance (host) from an item ID string.
    /// - Returns: The lowercase host if present (e.g., "neodb.social"), otherwise nil.
    var instance: String? {
        if let url = URL(string: self), let host = url.host, !host.isEmpty {
            return host.lowercased()
        }
        // Handle host without scheme, e.g. "neodb.social/book/abc".
        // If it looks like a host (contains '.'), take the segment before the first '/'.
        if let slash = self.firstIndex(of: "/") {
            let candidate = String(self[..<slash])
            if candidate.contains(".") { return candidate.lowercased() }
        } else if self.contains(".") { // raw host only
            return self.lowercased()
        }
        return nil
    }

    // MARK: - Strong NeoDB URL validation

    /// Returns the normalized UUID if this string is a valid NeoDB‑style item URL.
    /// Rules:
    /// - Host can be any domain (must exist), e.g. neodb.social, eggplant.place
    /// - First path component must match one of ItemCategory.urlPath values
    /// - The last path component is treated as the item id and must have a fixed length
    /// - Supports tv/season/<id> and podcast/episode/<id> (intermediate components allowed)
    /// - Returns nil if any rule fails
    var neodbUUIDIfValid: String? {
        guard let url = Self.coerceURL(from: self), url.host != nil else { return nil }

        let parts = url.path.split(separator: "/").map(String.init)
        guard parts.count >= 2 else { return nil }

        // Validate first segment against ItemCategory.urlPath universe (+ synonyms like "album")
        var allowedFirstSegments: Set<String> = Set(ItemCategory.allCases.map { $0.urlPath })
        allowedFirstSegments.insert("album") // legacy alias for .music
        guard allowedFirstSegments.contains(parts[0]) else { return nil }

        // The last non-empty path component must be the id and have expected length
        guard let last = parts.last, Self.isValidNeoDBId(last) else { return nil }
        return last
    }

    /// Returns true if this string is a valid NeoDB item URL per neodbUUIDIfValid rules.
    var isValidNeoDBItemURL: Bool { neodbUUIDIfValid != nil }

    /// Fixed-length validation for NeoDB item ids.
    /// Adjust here if the backend changes the id length.
    static func isValidNeoDBId(_ id: String) -> Bool {
        return id.count == Self.neodbIdLength
    }

    /// Expected NeoDB id length (currently 22).
    static var neodbIdLength: Int { 22 }

    // MARK: - Helpers
    private static func coerceURL(from string: String) -> URL? {
        if let u = URL(string: string), u.host != nil { return u }
        // Try to add https:// if missing scheme, for generic hosts (e.g., eggplant.place/book/..)
        let lower = string.lowercased()
        if !lower.hasPrefix("http://") && !lower.hasPrefix("https://") {
            return URL(string: "https://" + string)
        }
        return nil
    }

    // MARK: - Convert to standard ItemSchema
    /// Converts this `ItemID` (string) into a normalized ItemSchema when possible.
    ///
    /// Resolution order:
    /// 1) If the URL contains the legacy `~neodb~` marker, use NeoDBURL.parseItemURL
    /// 2) Else try strict path-based parsing (host flexible, category/id strict)
    /// 3) If it's only a bare UUID (22 chars), build a temporary item schema
    /// 4) Otherwise return nil
    public func toItem(title: String? = nil, coverImageUrl: URL? = nil) -> ItemSchema? {
        if let url = Self.coerceURL(from: self) {
            // Legacy marker-based parser
            if let anyItem = NeoDBURL.parseItemURL(url, title: title, coverImageUrl: coverImageUrl) {
                return anyItem.toItemSchema
            }
            // Strict NeoDB-style URL (no marker)
            if let anyItem = NeoDBURL.parseStrictItemURL(url, title: title, coverImageUrl: coverImageUrl) {
                return anyItem.toItemSchema
            }
        }

        // Bare UUID support: construct a temporary schema
        if ItemID.isValidNeoDBId(self) {
            if let url = URL(string: "https://unknown.neodb.net/unknown/\(self)") {
                var item = ItemSchema.makeTemporaryItemSchema(id: url)
                if let coverImageUrl {
                    item = ItemSchema(
                        id: item.id,
                        type: item.type,
                        uuid: item.uuid,
                        url: item.url,
                        apiUrl: item.apiUrl,
                        category: item.category,
                        parentUuid: item.parentUuid,
                        displayTitle: item.displayTitle,
                        externalResources: item.externalResources,
                        title: item.title,
                        description: item.description,
                        localizedTitle: item.localizedTitle,
                        localizedDescription: item.localizedDescription,
                        coverImageUrl: coverImageUrl,
                        rating: item.rating,
                        ratingCount: item.ratingCount,
                        ratingDistribution: item.ratingDistribution,
                        brief: item.brief
                    )
                }
                return item
            }
        }

        return nil
    }
}
