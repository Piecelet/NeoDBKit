//
//  MastodonStatus.swift
//  NeoDB
//
//  Created by citron on 1/13/25.
//
//  Based on https://github.com/Dimillian/IceCubesApp
//  Witch is licensed under the AGPL-3.0 License
//

import Foundation

public protocol MastodonStatusProtocol: Codable, Equatable, Hashable, Identifiable, Sendable {
    var id: String { get }
    var content: HTMLString { get }
    var account: MastodonAccount { get }
    var createdAt: ServerDate { get }
    var editedAt: ServerDate? { get }
    var mediaAttachments: [MastodonMediaAttachment] { get }
    var mentions: [MastodonMention] { get }
    var repliesCount: Int { get }
    var reblogsCount: Int { get }
    var quotesCount: Int? { get }
    var favouritesCount: Int { get }
    var tags: [MastodonTag] { get }
    var card: MastodonPreviewCard? { get }
    var favourited: Bool? { get }
    var reblogged: Bool? { get }
    var pinned: Bool? { get }
    var bookmarked: Bool? { get }
    var emojis: [MastodonEmoji] { get }
    var url: String? { get }
    var application: MastodonApplication? { get }
    var inReplyToId: String? { get }
    var inReplyToAccountId: String? { get }
    var visibility: MastodonVisibility { get }
    var poll: MastodonPoll? { get }
    var spoilerText: HTMLString { get }
    var filtered: [MastodonFiltered]? { get }
    var sensitive: Bool { get }
    var language: String? { get }
    var isHidden: Bool { get }
    var quote: MastodonQuote? { get }
    var quoteApproval: MastodonQuoteApproval? { get }

    // MARK: NeoDB Private
    //    var extNeodb: [NeoDBTag] {get}
    //    var relatedWith:

    // MARK: - NeoDB
}

public final class MastodonStatus: MastodonStatusProtocol
{
    public static func == (lhs: MastodonStatus, rhs: MastodonStatus) -> Bool {
        lhs.id == rhs.id && lhs.editedAt?.asDate == rhs.editedAt?.asDate
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public let id: String
    public let content: HTMLString
    public let account: MastodonAccount
    public let createdAt: ServerDate
    public let editedAt: ServerDate?
    public let reblog: MastodonReblogStatus?
    public let mediaAttachments: [MastodonMediaAttachment]
    public let mentions: [MastodonMention]
    public let repliesCount: Int
    public let reblogsCount: Int
    public let quotesCount: Int?
    public let favouritesCount: Int
    public let tags: [MastodonTag]
    public let card: MastodonPreviewCard?
    public let favourited: Bool?
    public let reblogged: Bool?
    public let pinned: Bool?
    public let bookmarked: Bool?
    public let emojis: [MastodonEmoji]
    public let url: String?
    public let application: MastodonApplication?
    public let inReplyToId: String?
    public let inReplyToAccountId: String?
    public let visibility: MastodonVisibility
    public let poll: MastodonPoll?
    public let spoilerText: HTMLString
    public let filtered: [MastodonFiltered]?
    public let sensitive: Bool
    public let language: String?
    public let quote: MastodonQuote?
    public let quoteApproval: MastodonQuoteApproval?


    public var isHidden: Bool {
        filtered?.first?.filter.filterAction == .hide
    }

    public var asMediaStatus: [MastodonMediaStatus] {
        mediaAttachments.map { .init(status: self, attachment: $0) }
    }
    init(
        id: String, content: HTMLString, account: MastodonAccount,
        createdAt: ServerDate, editedAt: ServerDate?,
        reblog: MastodonReblogStatus?,
        mediaAttachments: [MastodonMediaAttachment],
        mentions: [MastodonMention],
        repliesCount: Int, reblogsCount: Int, favouritesCount: Int, quotesCount: Int?,
        tags: [MastodonTag], card: MastodonPreviewCard?, favourited: Bool?,
        reblogged: Bool?, pinned: Bool?, bookmarked: Bool?,
        emojis: [MastodonEmoji], url: String?,
        application: MastodonApplication?, inReplyToId: String?,
        inReplyToAccountId: String?,
        visibility: MastodonVisibility, poll: MastodonPoll?, spoilerText: HTMLString,
        filtered: [MastodonFiltered]?,
        sensitive: Bool, language: String?, quote: MastodonQuote?,
        quoteApproval: MastodonQuoteApproval?
    ) {
        self.id = id
        self.content = content
        self.account = account
        self.createdAt = createdAt
        self.editedAt = editedAt
        self.reblog = reblog
        self.mediaAttachments = mediaAttachments
        self.mentions = mentions
        self.repliesCount = repliesCount
        self.reblogsCount = reblogsCount
        self.favouritesCount = favouritesCount
        self.quotesCount = quotesCount
        self.tags = tags
        self.card = card
        self.favourited = favourited
        self.reblogged = reblogged
        self.pinned = pinned
        self.bookmarked = bookmarked
        self.emojis = emojis
        self.url = url
        self.application = application
        self.inReplyToId = inReplyToId
        self.inReplyToAccountId = inReplyToAccountId
        self.visibility = visibility
        self.poll = poll
        self.spoilerText = spoilerText
        self.filtered = filtered
        self.sensitive = sensitive
        self.language = language
        self.quote = quote
        self.quoteApproval = quoteApproval
    }

    public static func placeholder(forSettings: Bool = false, language: String? = nil)
        -> MastodonStatus
    {
        .init(
            id: UUID().uuidString,
            content: .init(
                stringValue:
                    "Here's to the [#crazy](#) ones. The misfits.\nThe [@rebels](#). The troublemakers.",
                parseMarkdown: forSettings),

            account: .placeholder(),
            createdAt: ServerDate(),
            editedAt: nil,
            reblog: nil,
            mediaAttachments: [],
            mentions: [],
            repliesCount: 888,
            reblogsCount: 888,
            favouritesCount: 888, quotesCount: 2,
            tags: [],
            card: nil,
            favourited: false,
            reblogged: false,
            pinned: false,
            bookmarked: false,
            emojis: [],
            url: "https://piecelet.internal/placeholder",
            application: nil,
            inReplyToId: nil,
            inReplyToAccountId: nil,
            visibility: .pub,
            poll: nil,
            spoilerText: .init(stringValue: ""),
            filtered: [],
            sensitive: false,
            language: language,
            quote: nil,
            quoteApproval: nil)
    }

    public static func placeholders() -> [MastodonStatus] {
        [
            .placeholder(), .placeholder(), .placeholder(), .placeholder(),
            .placeholder(),
            .placeholder(), .placeholder(), .placeholder(), .placeholder(),
            .placeholder(),
        ]
    }

    public var reblogAsAsStatus: MastodonStatus? {
        if let reblog {
            return .init(
                id: reblog.id,
                content: reblog.content,
                account: reblog.account,
                createdAt: reblog.createdAt,
                editedAt: reblog.editedAt,
                reblog: nil,
                mediaAttachments: reblog.mediaAttachments,
                mentions: reblog.mentions,
                repliesCount: reblog.repliesCount,
                reblogsCount: reblog.reblogsCount,
                favouritesCount: reblog.favouritesCount, quotesCount: reblog.quotesCount,
                tags: reblog.tags,
                card: reblog.card,
                favourited: reblog.favourited,
                reblogged: reblog.reblogged,
                pinned: reblog.pinned,
                bookmarked: reblog.bookmarked,
                emojis: reblog.emojis,
                url: reblog.url,
                application: reblog.application,
                inReplyToId: reblog.inReplyToId,
                inReplyToAccountId: reblog.inReplyToAccountId,
                visibility: reblog.visibility,
                poll: reblog.poll,
                spoilerText: reblog.spoilerText,
                filtered: reblog.filtered,
                sensitive: reblog.sensitive,
                language: reblog.language,
                quote: reblog.quote,
                quoteApproval: reblog.quoteApproval)
        }
        return nil
    }

//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        content = try container.decode(HTMLString.self, forKey: .content)
//        account = try container.decode(MastodonAccount.self, forKey: .account)
//        createdAt = try container.decode(ServerDate.self, forKey: .createdAt)
//        editedAt = try container.decodeIfPresent(ServerDate.self, forKey: .editedAt)
//        reblog = try container.decodeIfPresent(MastodonReblogStatus.self, forKey: .reblog)
//        
//        // Handle mediaAttachments with a default empty array if missing
//        mediaAttachments = try container.decodeIfPresent([MastodonMediaAttachment].self, forKey: .mediaAttachments) ?? []
//        
//        mentions = try container.decode([MastodonMention].self, forKey: .mentions)
//        repliesCount = try container.decode(Int.self, forKey: .repliesCount)
//        reblogsCount = try container.decode(Int.self, forKey: .reblogsCount)
//        favouritesCount = try container.decode(Int.self, forKey: .favouritesCount)
//        tags = try container.decode([MastodonTag].self, forKey: .tags)
//        card = try container.decodeIfPresent(MastodonPreviewCard.self, forKey: .card)
//        favourited = try container.decodeIfPresent(Bool.self, forKey: .favourited)
//        reblogged = try container.decodeIfPresent(Bool.self, forKey: .reblogged)
//        pinned = try container.decodeIfPresent(Bool.self, forKey: .pinned)
//        bookmarked = try container.decodeIfPresent(Bool.self, forKey: .bookmarked)
//        emojis = try container.decode([MastodonEmoji].self, forKey: .emojis)
//        url = try container.decodeIfPresent(String.self, forKey: .url)
//        application = try container.decodeIfPresent(MastodonApplication.self, forKey: .application)
//        inReplyToId = try container.decodeIfPresent(String.self, forKey: .inReplyToId)
//        inReplyToAccountId = try container.decodeIfPresent(String.self, forKey: .inReplyToAccountId)
//        visibility = try container.decode(MastodonVisibility.self, forKey: .visibility)
//        poll = try container.decodeIfPresent(MastodonPoll.self, forKey: .poll)
//        spoilerText = try container.decode(HTMLString.self, forKey: .spoilerText)
//        filtered = try container.decodeIfPresent([MastodonFiltered].self, forKey: .filtered)
//        sensitive = try container.decode(Bool.self, forKey: .sensitive)
//        language = try container.decodeIfPresent(String.self, forKey: .language)
//    }
}

public final class MastodonReblogStatus: MastodonStatusProtocol
{
    public static func == (lhs: MastodonReblogStatus, rhs: MastodonReblogStatus)
        -> Bool
    {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public let id: String
    public let content: HTMLString
    public let account: MastodonAccount
    public let createdAt: ServerDate
    public let editedAt: ServerDate?
    public let mediaAttachments: [MastodonMediaAttachment]
    public let mentions: [MastodonMention]
    public let repliesCount: Int
    public let reblogsCount: Int
    public let favouritesCount: Int
    public let quotesCount: Int?
    public let tags: [MastodonTag]
    public let card: MastodonPreviewCard?
    public let favourited: Bool?
    public let reblogged: Bool?
    public let pinned: Bool?
    public let bookmarked: Bool?
    public let emojis: [MastodonEmoji]
    public let url: String?
    public let application: MastodonApplication?
    public let inReplyToId: String?
    public let inReplyToAccountId: String?
    public let visibility: MastodonVisibility
    public let poll: MastodonPoll?
    public let spoilerText: HTMLString
    public let filtered: [MastodonFiltered]?
    public let sensitive: Bool
    public let language: String?
    public let quote: MastodonQuote?
    public let quoteApproval: MastodonQuoteApproval?

    public var isHidden: Bool {
        filtered?.first?.filter.filterAction == .hide
    }

    init(
        id: String, content: HTMLString, account: MastodonAccount,
        createdAt: ServerDate, editedAt: ServerDate?,
        mediaAttachments: [MastodonMediaAttachment],
        mentions: [MastodonMention], repliesCount: Int, reblogsCount: Int,
        favouritesCount: Int, quotesCount:Int?, tags: [MastodonTag], card: MastodonPreviewCard?,
        favourited: Bool?, reblogged: Bool?, pinned: Bool?,
        bookmarked: Bool?, emojis: [MastodonEmoji], url: String?,
        application: MastodonApplication? = nil,
        inReplyToId: String?, inReplyToAccountId: String?,
        visibility: MastodonVisibility, poll: MastodonPoll?,
        spoilerText: HTMLString, filtered: [MastodonFiltered]?, sensitive: Bool,
        language: String?, quote: MastodonQuote?,
        quoteApproval: MastodonQuoteApproval?
    ) {
        self.id = id
        self.content = content
        self.account = account
        self.createdAt = createdAt
        self.editedAt = editedAt
        self.mediaAttachments = mediaAttachments
        self.mentions = mentions
        self.repliesCount = repliesCount
        self.reblogsCount = reblogsCount
        self.favouritesCount = favouritesCount
        self.quotesCount = quotesCount
        self.tags = tags
        self.card = card
        self.favourited = favourited
        self.reblogged = reblogged
        self.pinned = pinned
        self.bookmarked = bookmarked
        self.emojis = emojis
        self.url = url
        self.application = application
        self.inReplyToId = inReplyToId
        self.inReplyToAccountId = inReplyToAccountId
        self.visibility = visibility
        self.poll = poll
        self.spoilerText = spoilerText
        self.filtered = filtered
        self.sensitive = sensitive
        self.language = language
        self.quote = quote
        self.quoteApproval = quoteApproval
    }
}
