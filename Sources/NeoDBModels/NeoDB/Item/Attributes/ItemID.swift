//
//  ItemID.swift
//  NeoDB
//
//  Created by Codex on 9/18/25.
//

import Foundation

/// ItemID 是对底层 String 的轻量封装，用于 Item 标识符。
/// - JSON 中依然编码为一个纯字符串（例如 `"id": "..."`）
/// - 支持字面量初始化：`let id: ItemID = "..."`
/// - 内部值通过 `rawValue` 访问
public struct ItemID: Codable, Hashable, Equatable, Sendable,
    ExpressibleByStringLiteral, CustomStringConvertible
{

    public let rawValue: String

    // MARK: - 1) 内部 unsafe 初始化，用来绕过校验
    /// 只能在本文件内部用，Codable/工具函数可以用它创建“不一定合法”的 ItemID
    private init(unsafeRawValue: String) {
        self.rawValue = unsafeRawValue
    }

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(_ rawValue: URL) {
        self.rawValue = rawValue.absoluteString
    }

    public init?(parseFrom rawValue: String) {
        guard let url = URL(string: rawValue) else { return nil }
        self.init(parseFrom: url)
    }

    public init?(parseFrom rawValue: URL) {
        guard Self.testIsLikelyValid(rawValue) else { return nil }

        let path = rawValue.path

        // 2. 移除其中的 "~neodb~"
        let neodbCleanedPath = path.replacingOccurrences(
            of: "/\(NeoDBURL.neodbItemIdentifier)",
            with: ""
        )
        .replacingOccurrences(of: NeoDBURL.neodbItemIdentifier, with: "")

        // 3. 用清理后的路径重新组合 URL
        var components = URLComponents(url: rawValue, resolvingAgainstBaseURL: false)
        components?.path = neodbCleanedPath

        guard let finalURL = components?.url else { return nil }
        
        self.init(unsafeRawValue: finalURL.absoluteString)
    }

    // 字面量创建支持：let id: ItemID = "https://..."
    public init(stringLiteral value: String) {
        self.init(value)
    }

    // Codable：单值字符串编解码
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    // 打印/插值友好
    public var description: String { rawValue }

    public var rawURL: URL? {
        URL(string: rawValue)
    }
}

// 如果你想在 SwiftUI 等地方直接用，也可以顺手加上：
extension ItemID: Identifiable {
    public var id: String { rawValue }
}

// MARK: - Validity

extension ItemID {

    /// 静态检查给定 ItemID 是否“看起来合理”
    public static func testIsLikelyValid(_ input: String) -> Bool {
        return testIsLikelyValid(ItemID(input))
    }

    public static func testIsLikelyValid(_ input: URL) -> Bool {
        return testIsLikelyValid(ItemID(input))
    }

    public static func testIsLikelyValid(_ input: ItemID) -> Bool {
        // print("Testing likely valid for ItemID: \(input.rawValue), type: \(String(describing: input.type)), category: \(String(describing: input.category)), likelyValidUUID: \(String(describing: input.likelyValidUUID))")
        guard let _ = input.type,
            let _ = input.category,
            let _ = input.likelyValidUUID,
            input.rawValue.contains("/") == true
        else {
            return false
        }
        return true
    }

    /// 当前 ID 是否“看起来合理”
    public var isLikelyValid: Bool {
        Self.testIsLikelyValid(self)
    }
}

// MARK: - UUID 解析

extension ItemID {
    /// 从字符串中提取 UUID 部分。
    /// - 返回：最后一个非空 path component。
    /// 示例：
    /// - "https://neodb.social/book/abc123" -> "abc123"
    /// - "/tv/season/xyz" -> "xyz"
    /// - "plain-uuid" -> "plain-uuid"
    public func toUUID(_ input: String, forceString: Bool = false) -> ItemUUID {
        // 优先用 URL 解析，避免 query/fragment 干扰
        if let url = URL(string: input), forceString == false {
            return toUUID(url)
        }
        // Fallback: strip query, then split by '/'
        let head =
            self.rawValue.split(separator: "?", maxSplits: 1).first.map(
                String.init
            ) ?? self.rawValue
        return head.components(separatedBy: "/").last ?? head
    }

    public func toUUID(_ input: URL) -> ItemUUID {
        if let likelyValidUUID = self.toLikelyValidUUID(input) {
            return likelyValidUUID
        }
        return toUUID(input.absoluteString, forceString: true)
    }

    /// 使用自身字符串解析 UUID
    public var uuid: ItemUUID {
        toUUID(rawValue)
    }

    public func toLikelyValidUUID(_ input: String) -> ItemUUID? {
        if let url = URL(string: input) {
            return toLikelyValidUUID(url)
        }
        return nil
    }

    public func toLikelyValidUUID(_ input: URL) -> ItemUUID? {
        let path = input.path
        if let last = path.split(separator: "/").last {
            return String(last)  // ItemUUID 目前是 String alias 的话这里是 OK 的
        }
        return nil
    }

    /// 只在看起来合法时返回 UUID
    public var likelyValidUUID: ItemUUID? {
        toLikelyValidUUID(rawValue)
    }
}

// MARK: - Instance (host) 解析

extension ItemID {
    /// 尝试从 ItemID 字符串中提取实例（host）
    /// - 返回：小写 host（例如 "neodb.social"），否则为 nil。
    public var instance: String? {
        let value = rawValue

        if let url = URL(string: value),
            let host = url.host,
            !host.isEmpty
        {
            return host.lowercased()
        }

        // 处理无 scheme 的 host，如 "neodb.social/book/abc"
        if let slash = value.firstIndex(of: "/") {
            let candidate = String(value[..<slash])
            if candidate.contains(".") {
                return candidate.lowercased()
            }
        } else if value.contains(".") {  // 只有 host 本身
            return value.lowercased()
        }

        return nil
    }
}

// MARK: - Type / Category 解析

extension ItemID {
    public var type: ItemType? {
        toType(rawValue)
    }

    public var category: ItemCategory? {
        toCategory(rawValue)
    }

    public func toType(_ input: String) -> ItemType? {
        if let url = URL(string: input) {
            return toType(url)
        }
        return nil
    }

    public func toType(_ input: URL) -> ItemType? {
        guard
            let components = URLComponents(
                url: input,
                resolvingAgainstBaseURL: true
            )
        else {
            return nil
        }

        let path = components.path.dropFirst()  // 去掉前导 '/'
        let parts = path.split(separator: "/").map(String.init)
        guard parts.count >= 1 else { return nil }

        let first = parts[0].lowercased()
        switch first {
        case "book":
            return .book
        case "movie":
            return .movie
        case "tv":
            if parts.count >= 2 {
                switch parts[1].lowercased() {
                case "season": return .tvSeason
                case "episode": return .tvEpisode
                default: return .tv
                }
            } else {
                return .tv
            }
        case "music", "album":
            return .music
        case "podcast":
            if parts.count >= 2 && parts[1].lowercased() == "episode" {
                return .podcastEpisode
            } else {
                return .podcast
            }
        case "game":
            return .game
        case "performance":
            if parts.count >= 2 && parts[1].lowercased() == "production" {
                return .performanceProduction
            } else {
                return .performance
            }
        default:
            return nil
        }
    }

    public func toCategory(_ input: String) -> ItemCategory? {
        toType(input)?.category
    }

    public func toCategory(_ input: URL) -> ItemCategory? {
        toType(input)?.category
    }
}

// MARK: - NeoDB URL 校验 & 转 ItemSchema

extension ItemID {
    /// 如果当前字符串是合法的 NeoDB 风格 item URL，返回标准化后的 UUID。
    ///
    /// 规则：
    /// - host 必须存在（域名不限）
    /// - 第一个 path segment 必须在 ItemCategory.urlPath 集合中（含 "album" 等别名）
    /// - 最后一个 path segment 作为 id，长度需符合 ItemUUID 的规则
    /// - 支持 tv/season/<id>、podcast/episode/<id> 等
    public var neodbUUIDIfValid: ItemUUID? {
        guard let url = Self.coerceURL(from: rawValue),
            url.host != nil
        else { return nil }

        let parts = url.path.split(separator: "/").map(String.init)
        guard parts.count >= 2 else { return nil }

        // 校验第一个 segment
        var allowedFirstSegments = Set(ItemCategory.allCases.map { $0.urlPath })
        allowedFirstSegments.insert("album")  // .music 的兼容别名
        guard let first = parts.first,
            allowedFirstSegments.contains(first)
        else {
            return nil
        }

        // 最后一个 segment 必须是合法 UUID
        guard let last = parts.last,
            ItemUUID.testIsLikelyValid(last)
        else {
            return nil
        }

        return last
    }

    /// 按 neodbUUIDIfValid 规则检查是否为合法 NeoDB Item URL。
    public var isValidNeoDBItemURL: Bool { neodbUUIDIfValid != nil }

    // MARK: - Helpers

    private static func coerceURL(from string: String) -> URL? {
        if let u = URL(string: string), u.host != nil {
            return u
        }
        // 没有 scheme 时自动补 https://
        let lower = string.lowercased()
        if !lower.hasPrefix("http://") && !lower.hasPrefix("https://") {
            return URL(string: "https://" + string)
        }
        return nil
    }

    public func parseFrom(_ string: String) -> ItemID? {
        guard let url = Self.coerceURL(from: string) else {
            return nil
        }
        return parseFrom(url)
    }

    public func parseFrom(_ url: URL) -> ItemID? {
        let path = url.path

        // 2. 移除其中的 "~neodb~"
        let neodbCleanedPath = path.replacingOccurrences(
            of: "/\(NeoDBURL.neodbItemIdentifier)",
            with: ""
        )
        .replacingOccurrences(of: NeoDBURL.neodbItemIdentifier, with: "")

        // 3. 用清理后的路径重新组合 URL
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.path = neodbCleanedPath

        guard let finalURL = components?.url else { return nil }

        return ItemID(finalURL)
    }

    // MARK: - 转标准 ItemSchema

    /// 尝试把当前 `ItemID` 转换为标准化的 ItemSchema。
    ///
    /// 解析顺序：
    /// 1. 如果 URL 中含有旧的 `~neodb~` 标记，用 `NeoDBURL.parseItemURL`
    /// 2. 否则尝试严格 path 解析（host 宽松，category/id 严格）
    /// 3. 如果只是裸 UUID（例如 22 长度符合规则），构造临时 ItemSchema
    /// 4. 否则返回 nil
    public func makeItem(
        title: String? = nil,
        description: String? = nil,
        coverImageUrl: URL? = nil,
        rating: Double? = nil,
        ratingCount: Int? = nil
    ) -> ItemSchema? {
        guard self.isLikelyValid else {
            return nil
        }

        let item = ItemSchema.makeItemSchema(
            id: self,
            title: title,
            description: description,
            coverImageUrl: coverImageUrl,
            rating: rating,
            ratingCount: ratingCount
        )
        return item

        // if let url = Self.coerceURL(from: rawValue) {
        //     // 旧标记解析
        //     if let anyItem = NeoDBURL.parseItemURL(
        //         url,
        //         title: title,
        //         coverImageUrl: coverImageUrl
        //     ) {
        //         return anyItem.toItemSchema
        //     }
        //     // 严格 NeoDB 风格解析
        //     if let anyItem = NeoDBURL.parseStrictItemURL(
        //         url,
        //         title: title,
        //         coverImageUrl: coverImageUrl
        //     ) {
        //         return anyItem.toItemSchema
        //     }
        // }

        // // 裸 UUID：构造一个临时 schema
        // if ItemID.testIsLikelyValid(self) {
        //     if let url = URL(
        //         string: "https://unknown.neodb.net/unknown/\(rawValue)"
        //     ) {
        //         var item = ItemSchema.makeTemporaryItemSchema(id: url)
        //         if let coverImageUrl {
        //             item = ItemSchema(
        //                 id: item.id,
        //                 type: item.type,
        //                 uuid: item.uuid,
        //                 url: item.url,
        //                 apiUrl: item.apiUrl,
        //                 category: item.category,
        //                 parentUuid: item.parentUuid,
        //                 displayTitle: item.displayTitle,
        //                 externalResources: item.externalResources,
        //                 title: item.title,
        //                 description: item.description,
        //                 localizedTitle: item.localizedTitle,
        //                 localizedDescription: item.localizedDescription,
        //                 coverImageUrl: coverImageUrl,
        //                 rating: item.rating,
        //                 ratingCount: item.ratingCount,
        //                 ratingDistribution: item.ratingDistribution
        //             )
        //         }
        //         return item
        //     }
        // }

        // return nil
    }
}
