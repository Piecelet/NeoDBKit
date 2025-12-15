//
//  MastodonAccount.swift
//  NeoDB
//
//  Created by citron on 1/13/25.
//
//  From https://github.com/Dimillian/IceCubesApp
//  Witch is licensed under the AGPL-3.0 License
//

import Foundation

public final class MastodonAccount: Codable, Identifiable, Hashable, Sendable,
    Equatable
{
    public static func == (lhs: MastodonAccount, rhs: MastodonAccount) -> Bool {
        lhs.id == rhs.id && lhs.username == rhs.username
            && lhs.note.asRawText == rhs.note.asRawText
            && lhs.statusesCount == rhs.statusesCount
            && lhs.followersCount == rhs.followersCount
            && lhs.followingCount == rhs.followingCount && lhs.acct == rhs.acct
            && lhs.displayName == rhs.displayName && lhs.fields == rhs.fields
            && lhs.lastStatusAt == rhs.lastStatusAt
            && lhs.discoverable == rhs.discoverable
            && lhs.bot == rhs.bot && lhs.locked == rhs.locked
            && lhs.avatar == rhs.avatar
            && lhs.header == rhs.header
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public struct Field: Codable, Equatable, Identifiable, Sendable {
        public var id: String {
            value.asRawText + name
        }

        public let name: String
        public let value: HTMLString
        public let verifiedAt: String?
    }

    public struct Source: Codable, Equatable, Sendable {
        public let privacy: MastodonVisibility
        public let sensitive: Bool
        public let language: String?
        public let note: String
        public let fields: [Field]
    }

    public let id: String
    public let username: String
    public let displayName: String?
    public let cachedDisplayName: HTMLString
    public let avatar: URL?
    public let header: URL?
    public let acct: String
    public let note: HTMLString
    public let createdAt: ServerDate
    public let followersCount: Int?
    public let followingCount: Int?
    public let statusesCount: Int?
    public let lastStatusAt: String?
    public let fields: [Field]
    public let locked: Bool
    public let emojis: [MastodonEmoji]
    public let url: URL?
    public let source: Source?
    public let bot: Bool
    public let discoverable: Bool?
    public let moved: MastodonAccount?

    public var haveAvatar: Bool {
        if let avatar {
            return !avatar.lastPathComponent.contains("missing")
        }
        return false
    }

    public var haveHeader: Bool {
        if let header {
            return !header.lastPathComponent.contains("missing")
        }
        return false
    }

    public var fullAccountName: String {
        "\(acct)@\(url?.host() ?? "")"
    }

    init(
        id: String, username: String, displayName: String?, avatar: URL?,
        header: URL?, acct: String,
        note: HTMLString, createdAt: ServerDate, followersCount: Int,
        followingCount: Int,
        statusesCount: Int, lastStatusAt: String? = nil,
        fields: [MastodonAccount.Field], locked: Bool,
        emojis: [MastodonEmoji], url: URL? = nil, source: Source? = nil,
        bot: Bool,
        discoverable: Bool? = nil, moved: MastodonAccount? = nil
    ) {
        self.id = id
        self.username = username
        self.displayName = displayName
        self.avatar = avatar
        self.header = header
        self.acct = acct
        self.note = note
        self.createdAt = createdAt
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.statusesCount = statusesCount
        self.lastStatusAt = lastStatusAt
        self.fields = fields
        self.locked = locked
        self.emojis = emojis
        self.url = url
        self.source = source
        self.bot = bot
        self.discoverable = discoverable
        self.moved = moved

        if let displayName, !displayName.isEmpty {
            cachedDisplayName = .init(stringValue: displayName)
        } else {
            cachedDisplayName = .init(stringValue: "@\(username)")
        }
    }

    public enum CodingKeys: CodingKey {
        case id
        case username
        case displayName
        case avatar
        case header
        case acct
        case note
        case createdAt
        case followersCount
        case followingCount
        case statusesCount
        case lastStatusAt
        case fields
        case locked
        case emojis
        case url
        case source
        case bot
        case discoverable
        case moved
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        
        // Handle avatar URL
        if let avatarString = try container.decodeIfPresent(String.self, forKey: .avatar),
           !avatarString.isEmpty {
            avatar = URL(string: avatarString)
        } else {
            avatar = nil
        }
        
        // Handle header URL
        if let headerString = try container.decodeIfPresent(String.self, forKey: .header),
           !headerString.isEmpty {
            header = URL(string: headerString)
        } else {
            header = nil
        }
        
        acct = try container.decode(String.self, forKey: .acct)
        note = try container.decode(HTMLString.self, forKey: .note)
        createdAt = try container.decode(ServerDate.self, forKey: .createdAt)
        followersCount = try container.decodeIfPresent(Int.self, forKey: .followersCount)
        followingCount = try container.decodeIfPresent(Int.self, forKey: .followingCount)
        statusesCount = try container.decodeIfPresent(Int.self, forKey: .statusesCount)
        lastStatusAt = try container.decodeIfPresent(String.self, forKey: .lastStatusAt)
        fields = try container.decode([MastodonAccount.Field].self, forKey: .fields)
        locked = try container.decode(Bool.self, forKey: .locked)
        emojis = try container.decode([MastodonEmoji].self, forKey: .emojis)
        
        // Handle URL
        if let urlString = try container.decodeIfPresent(String.self, forKey: .url),
           !urlString.isEmpty {
            url = URL(string: urlString)
        } else {
            url = nil
        }
        
        source = try container.decodeIfPresent(MastodonAccount.Source.self, forKey: .source)
        bot = try container.decode(Bool.self, forKey: .bot)
        discoverable = try container.decodeIfPresent(Bool.self, forKey: .discoverable)
        moved = try container.decodeIfPresent(MastodonAccount.self, forKey: .moved)

        if let displayName, !displayName.isEmpty {
            cachedDisplayName = .init(stringValue: displayName)
        } else {
            cachedDisplayName = .init(stringValue: "@\(username)")
        }
    }

    public static func placeholder() -> MastodonAccount {
        .init(
            id: UUID().uuidString,
            username: "Username",
            displayName: "John Mastodon",
            avatar: URL(
                string:
                    "https://files.mastodon.social/media_attachments/files/003/134/405/original/04060b07ddf7bb0b.png"
            )!,
            header: URL(
                string:
                    "https://files.mastodon.social/media_attachments/files/003/134/405/original/04060b07ddf7bb0b.png"
            )!,
            acct: "johnm@example.com",
            note: .init(stringValue: "Some content"),
            createdAt: ServerDate(),
            followersCount: 10,
            followingCount: 10,
            statusesCount: 10,
            lastStatusAt: nil,
            fields: [],
            locked: false,
            emojis: [],
            url: nil,
            source: nil,
            bot: false,
            discoverable: true)
    }

    public static func placeholders() -> [MastodonAccount] {
        [
            .placeholder(), .placeholder(), .placeholder(), .placeholder(),
            .placeholder(),
            .placeholder(), .placeholder(), .placeholder(), .placeholder(),
            .placeholder(),
        ]
    }
}

public struct MastodonFamiliarAccounts: Decodable {
    public let id: String
    public let accounts: [MastodonAccount]
}

extension MastodonFamiliarAccounts: Sendable {}

extension MastodonAccount {
    public func toNeoDBUser(_ account: MastodonAccount, externalAcct: String? = nil, externalAccounts: [ExternalAccount] = []) -> User {
        // Extract host from Mastodon profile URL (e.g., https://neodb.social/@demo/)
        // Convert to NeoDB format: https://neodb.social/users/demo/
        let neodbUserUrl: URL
        
        if let mastodonUrl = account.url,
           let host = mastodonUrl.host() {
            // Build NeoDB user URL with /users/{username}/ path
            var components = URLComponents()
            components.scheme = mastodonUrl.scheme ?? "https"
            components.host = host
            components.path = "/users/\(account.username)/"
            
            neodbUserUrl = components.url ?? URL(string: "https://\(host)/users/\(account.username)/")!
        } else {
            // Fallback if URL parsing fails
            neodbUserUrl = URL(string: "https://neodb.internal/users/\(account.username)/")!
        }
        
        return User(
            url: neodbUserUrl,
            externalAcct: externalAcct,
            externalAccounts: externalAccounts,
            displayName: account.displayName ?? account.username,
            avatar: account.avatar ?? URL(string: "https://piecelet.internal/placeholder")!,
            username: account.username,
            roles: []
        )
    }

    public var asNeoDBUser: User {
        return toNeoDBUser(self)
    }
}