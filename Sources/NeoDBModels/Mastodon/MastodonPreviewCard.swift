//
//  MastodonPreviewCard.swift
//  NeoDB
//
//  Created by citron on 1/13/25.
//
//  Based on https://github.com/Dimillian/IceCubesApp
//  Witch is licensed under the AGPL-3.0 License
//

import Foundation
import CoreGraphics

public struct MastodonPreviewCard: Codable, Identifiable, Equatable, Hashable {
    public var id: String {
        url.absoluteString
    }

    public let url: URL
    public let title: String?
    public let description: String?
    public let type: String
    public let authors: [MastodonPreviewCardAuthor]?
    public let authorName: String?
    public let authorUrl: URL?
    public let providerName: String?
    public let providerUrl: URL?
    public let html: HTMLString?
    public let width: CGFloat
    public let height: CGFloat
    
    // Type Video, Photo, Rich and Link
    public let image: URL?
    public let embedUrl: URL?
    public let blurhash: String?

    // Type Link
    public let history: [MastodonHistory]?
}

public struct MastodonPreviewCardAuthor: Codable, Sendable, Identifiable, Equatable, Hashable {
    public var id: String {
        url
    }

    public let name: String
    public let url: String
    public let account: MastodonAccount?
}

public enum MastodonPreviewCardType: String, Codable, Sendable {
    case link
    case photo
    case video
    case rich
}

extension MastodonPreviewCard: Sendable {}

// MARK: - Tolerant Decoding for optional URL fields and numeric sizes
public extension MastodonPreviewCard {
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case description
        case type
        case authors
        case authorName
        case authorUrl
        case providerName
        case providerUrl
        case html
        case width
        case height
        case image
        case embedUrl
        case blurhash
        case history
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Required URL
        let urlString = try container.decode(String.self, forKey: .url)
        guard let mainURL = URL(string: urlString) else {
            throw DecodingError.dataCorruptedError(forKey: .url, in: container, debugDescription: "Invalid URL string for 'url'")
        }
        url = mainURL

        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        type = (try? container.decode(String.self, forKey: .type)) ?? "link"
        authors = try container.decodeIfPresent([MastodonPreviewCardAuthor].self, forKey: .authors)
        authorName = try container.decodeIfPresent(String.self, forKey: .authorName)

        func decodeOptionalURL(for key: CodingKeys) -> URL? {
            // Try string first to tolerate empty/invalid
            if let s = ((try? container.decodeIfPresent(String.self, forKey: key)) ?? nil) {
                let trimmed = s.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.isEmpty { return nil }
                return URL(string: trimmed)
            }
            // Fallback to URL decoding if server is well-formed
            if let u = ((try? container.decodeIfPresent(URL.self, forKey: key)) ?? nil) {
                return u
            }
            return nil
        }
        authorUrl = decodeOptionalURL(for: .authorUrl)
        providerName = try container.decodeIfPresent(String.self, forKey: .providerName)
        providerUrl = decodeOptionalURL(for: .providerUrl)

        // HTML can be either a string or a structured object; the type supports both
        html = try container.decodeIfPresent(HTMLString.self, forKey: .html)

        func decodeCGFloat(for key: CodingKeys) -> CGFloat {
            if let d = try? container.decodeIfPresent(Double.self, forKey: key) {
                return CGFloat(d ?? 0)
            }
            if let i = try? container.decodeIfPresent(Int.self, forKey: key) {
                return CGFloat(i ?? 0)
            }
            return 0
        }
        width = decodeCGFloat(for: .width)
        height = decodeCGFloat(for: .height)

        image = decodeOptionalURL(for: .image)
        embedUrl = decodeOptionalURL(for: .embedUrl)
        blurhash = try container.decodeIfPresent(String.self, forKey: .blurhash)
        history = try container.decodeIfPresent([MastodonHistory].self, forKey: .history)
    }
}
