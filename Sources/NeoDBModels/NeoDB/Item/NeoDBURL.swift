//
//  NeoDBURL.swift
//  NeoDB
//
//  Created by citron on 1/19/25.
//

import Foundation
//import OSLog
import SwiftSoup

public class NeoDBURL {
//    private static let logger = Logger.services.url.neodbURL
    public static let neodbItemIdentifier = "~neodb~"
    private static let isDebugLoggingEnabled = false
    
    private static func log(_ message: String) {
        guard isDebugLoggingEnabled else { return }
//        logger.debug("\(message)")
    }


    public static func parseItemURL(_ url: URL, title: String? = nil, coverImageUrl: URL? = nil) -> (any ItemProtocol)? {
        guard
            let components = URLComponents(
                url: url, resolvingAgainstBaseURL: true),
            components.path.contains(neodbItemIdentifier)
        else {
            log("Not a NeoDB URL: \(url.absoluteString)")
            return nil
        }

        // Remove leading slash and split path
        let path = components.path.dropFirst()
        let pathComponents = path.split(separator: "/").map(String.init)

        // Verify we have ~neodb~/type/id format
        guard pathComponents.count >= 3,
            pathComponents[0] == neodbItemIdentifier
        else {
            log("Invalid NeoDB URL format: \(components.path)")
            return nil
        }

        let type = pathComponents[1]
        var uuid = pathComponents[2]
        let lowerType = type.lowercased()

        // Handle special cases for tv seasons and episodes
        let itemType: ItemType
        if lowerType == "podcast" && pathComponents.count >= 4 {
            if pathComponents[2] == "episode" {
                itemType = .podcastEpisode
                uuid = pathComponents[3]
            } else {
                itemType = .podcast
                uuid = pathComponents[2]
            }
        } else if lowerType == "tv" && pathComponents.count >= 4 {
            switch pathComponents[2] {
            case "season":
                itemType = .tvSeason
            case "episode":
                itemType = .tvEpisode
            default:
                itemType = .tv
            }
            uuid = pathComponents[3]
        } else if lowerType == "tv" {
            itemType = .tv
        } else if lowerType == "album" {
            itemType = .music
        } else if lowerType == "performance" && pathComponents.count >= 4 && pathComponents[2].lowercased() == "production" {
            itemType = .performanceProduction
            uuid = pathComponents[3]
        } else if let itemTypeDecode = ItemType.allCases.first(where: { $0.rawValue.lowercased() == lowerType }) {
            itemType = itemTypeDecode
        } else {
            log("Unknown item type: \(type), defaulting to book")
            itemType = .unknown
        }

        log("Processing NeoDB URL - type: \(type), uuid: \(uuid)")

        // Create item URL by removing ~neodb~
        var itemComponents = components
        itemComponents.path = itemComponents.path.replacingOccurrences(
            of: "/\(neodbItemIdentifier)", with: "")

        // Create API URL by replacing ~neodb~ with api
        var apiComponents = components
        apiComponents.path = apiComponents.path.replacingOccurrences(
            of: "/\(neodbItemIdentifier)", with: "/api")

        // Create a temporary ItemSchema
        let urlItem = ItemSchema(
            id: ItemID(itemComponents.url ?? url),
            type: itemType,
            uuid: uuid,
            url: itemComponents.url?.absoluteString ?? url.absoluteString,
            apiUrl: apiComponents.url?.absoluteString ?? url.absoluteString,
            category: itemType.category ?? .book,
            parentUuid: nil,
            displayTitle: title,
            externalResources: nil,
            title: title,
            description: nil,
            localizedTitle: nil,
            localizedDescription: nil,
            coverImageUrl: coverImageUrl,
            rating: nil,
            ratingCount: nil,
            ratingDistribution: nil,
        )

        log("Created ItemSchema for \(itemType.rawValue)")
        return urlItem
    }

    // MARK: - Strict parser without ~neodb~ marker (code-reused by URLHandler)
    /// Parses a NeoDB-style item URL even when it doesn't contain the `~neodb~` marker.
    /// Uses ItemID.neodbUUIDIfValid for validation and path-based category extraction.
    public static func parseStrictItemURL(_ url: URL, title: String? = nil, coverImageUrl: URL? = nil) -> (any ItemProtocol)? {
        let raw: ItemID = ItemID(url)
        guard let uuid = raw.neodbUUIDIfValid,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        // Split path without leading '/'
        let path = components.path.dropFirst()
        let parts = path.split(separator: "/").map(String.init)
        guard parts.count >= 2 else { return nil }

        let first = parts[0].lowercased()
        var itemType: ItemType
        var finalUUID = uuid

        if first == "podcast" {
            if parts.count >= 3 && parts[1] == "episode" {
                itemType = .podcastEpisode
                finalUUID = parts[2]
            } else {
                itemType = .podcast
                finalUUID = parts[1]
            }
        } else if first == "tv" {
            if parts.count >= 3 {
                switch parts[1] {
                case "season":
                    itemType = .tvSeason
                    if parts.count >= 3 { finalUUID = parts[2] }
                case "episode":
                    itemType = .tvEpisode
                    if parts.count >= 3 { finalUUID = parts[2] }
                default:
                    itemType = .tv
                    finalUUID = parts[1]
                }
            } else {
                itemType = .tv
                finalUUID = parts.last ?? uuid
            }
        } else if first == "album" {
            // Legacy alias for music
            itemType = .music
            finalUUID = parts[1]
        } else if first == "performance" && parts.count >= 3 && parts[1].lowercased() == "production" {
            itemType = .performanceProduction
            finalUUID = parts[2]
        } else if let typ = ItemType.allCases.first(where: { $0.rawValue.lowercased() == first }) {
            itemType = typ
            finalUUID = parts[1]
        } else {
            return nil
        }

        // Validate id length again (defensive)
        guard ItemUUID.testIsLikelyValid(finalUUID) else { return nil }

        // Build a minimal ItemSchema
        let item = ItemSchema(
            id: ItemID(url),
            type: itemType,
            uuid: finalUUID,
            url: url.absoluteString,
            apiUrl: url.absoluteString,
            category: itemType.category ?? .book,
            parentUuid: nil,
            displayTitle: title,
            externalResources: nil,
            title: title,
            description: nil,
            localizedTitle: nil,
            localizedDescription: nil,
            coverImageUrl: coverImageUrl,
            rating: nil,
            ratingCount: nil,
            ratingDistribution: nil
        )
        return item
    }
}
