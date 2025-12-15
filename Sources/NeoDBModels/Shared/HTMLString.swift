//
//  HTMLString.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  From https://github.com/Dimillian/IceCubesApp
//  Witch is licensed under the AGPL-3.0 License
//

import Foundation
import SwiftSoup
import SwiftUI

public enum CodingKeys: CodingKey {
    case htmlValue, asMarkdown, asRawText, statusesURLs, links, hadTrailingTags
}

public struct HTMLString: Codable, Equatable, Hashable, @unchecked Sendable {
    // MARK: - Cached regex and markdown options for performance
    private static let mainRegexCached: NSRegularExpression? = try? NSRegularExpression(
        pattern: "([\\*\\`\\~\\[\\\\])", options: .caseInsensitive)
    private static let underscoreRegexCached: NSRegularExpression? = try? NSRegularExpression(
        pattern: "(?!\\B:[^:]*)(_)(?![^:]*:\\B)", options: .caseInsensitive)
    private static let markdownOptionsCached = AttributedString.MarkdownParsingOptions(
        allowsExtendedAttributes: true,
        interpretedSyntax: .inlineOnlyPreservingWhitespace
    )
    public var htmlValue: String = ""
    public var asMarkdown: String = ""
    public var asRawText: String = ""
    public var statusesURLs = [URL]()
    public private(set) var links = [Link]()
    public private(set) var hadTrailingTags = false

    public var asSafeMarkdownAttributedString: AttributedString = .init()
    private var safeMarkdownAttributedStringWithoutNeoDBStatusCached: AttributedString = .init()

    private static func makeSafeMarkdownAttributedStringWithoutNeoDBStatus(from markdown: String) -> AttributedString {
        var text = markdown
        let lines = text.split(separator: "\n", maxSplits: 1)
        if let firstLine = lines.first, firstLine.contains("~neodb~") {
            text = lines.count > 1 ? String(lines[1]) : ""
        }

        text = text.trimmingCharacters(in: .newlines)
        do {
            return try AttributedString(markdown: text, options: Self.markdownOptionsCached)
        } catch {
            return AttributedString(text)
        }
    }

    // 获取第一行（如果包含 ~neodb~）
    public var neodbStatusLine: String? {
        let lines = asMarkdown.split(separator: "\n", maxSplits: 1)
        guard let firstLine = lines.first,
              firstLine.contains("~neodb~") else {
            return nil
        }
        return String(firstLine)
    }
    
    // 获取第一行的 AttributedString（如果是 NeoDB 状态行）
    public var neodbStatusLineAttributedString: AttributedString? {
        guard let statusLine = neodbStatusLine else {
            return nil
        }
        return (try? AttributedString(markdown: statusLine)) ?? AttributedString(statusLine)
    }
    
    // 获取不包含评分的 NeoDB 状态行
    public var neodbStatusLineAttributedStringWithoutRating: AttributedString? {
        guard let statusLine = neodbStatusLine else {
            return nil
        }
        // 移除评分字符
        var text = statusLine
        let ratingPattern = "[🌕🌗🌑]+"
        if let regex = try? NSRegularExpression(pattern: ratingPattern) {
            text = regex.stringByReplacingMatches(
                in: text,
                range: NSRange(text.startIndex..., in: text),
                withTemplate: ""
            )
        }
        return (try? AttributedString(markdown: text)) ?? AttributedString(text)
    }
    
    // 获取不包含 NeoDB 状态行的内容
    public var asSafeMarkdownAttributedStringWithoutNeoDBStatus: AttributedString {
        safeMarkdownAttributedStringWithoutNeoDBStatusCached
    }
    
    public var asSafeMarkdownAttributedStringWithoutRating: AttributedString {
        var text = asMarkdown
        // 移除评分字符
        let ratingPattern = "[🌕🌗🌑]+"
        if let regex = try? NSRegularExpression(pattern: ratingPattern) {
            text = regex.stringByReplacingMatches(
                in: text,
                range: NSRange(text.startIndex..., in: text),
                withTemplate: ""
            )
        }
        return (try? AttributedString(markdown: text)) ?? AttributedString(text)
    }
    
    public var rating: Double? {
        // 查找评分字符串
        let ratingPattern = "[🌕🌗🌑]+"
        guard let regex = try? NSRegularExpression(pattern: ratingPattern),
              let match = regex.firstMatch(
                in: asMarkdown,
                range: NSRange(asMarkdown.startIndex..., in: asMarkdown)
              ),
              let range = Range(match.range, in: asMarkdown) else {
            return nil
        }
        
        let ratingString = String(asMarkdown[range])
        
        // 计算评分
        var score = 0.0
        for char in ratingString {
            switch char {
            case "🌕":
                score += 2.0
            case "🌗":
                score += 1.0
            case "🌑":
                score += 0.0
            default:
                continue
            }
        }
        
        return score
    }
    
    private var main_regex: NSRegularExpression?
    private var underscore_regex: NSRegularExpression?
    public init(from decoder: Decoder) {
        var alreadyDecoded = false
        do {
            let container = try decoder.singleValueContainer()
            htmlValue = try container.decode(String.self)
        } catch {
            do {
                alreadyDecoded = true
                let container = try decoder.container(keyedBy: CodingKeys.self)
                htmlValue = try container.decode(
                    String.self, forKey: .htmlValue)
                asMarkdown = try container.decode(
                    String.self, forKey: .asMarkdown)
                asRawText = try container.decode(
                    String.self, forKey: .asRawText)
                statusesURLs = try container.decode(
                    [URL].self, forKey: .statusesURLs)
                links = try container.decode([Link].self, forKey: .links)
                hadTrailingTags =
                    (try? container.decode(Bool.self, forKey: .hadTrailingTags)) ?? false
            } catch {
                htmlValue = ""
            }
        }

        if !alreadyDecoded {
            parseHTML(htmlValue)
        } else {
            do {
                asSafeMarkdownAttributedString = try AttributedString(
                    markdown: asMarkdown.trimmingCharacters(in: .whitespacesAndNewlines), options: Self.markdownOptionsCached)
            } catch {
                asSafeMarkdownAttributedString = AttributedString(
                    stringLiteral: htmlValue)
            }
            safeMarkdownAttributedStringWithoutNeoDBStatusCached =
                Self.makeSafeMarkdownAttributedStringWithoutNeoDBStatus(from: asMarkdown)
        }
    }

    public init(stringValue: String, parseMarkdown: Bool = false) {
        htmlValue = stringValue
        asMarkdown = stringValue
        asRawText = stringValue
        statusesURLs = []
        hadTrailingTags = false

        if parseMarkdown {
            do {
                asSafeMarkdownAttributedString = try AttributedString(
                    markdown: asMarkdown, options: Self.markdownOptionsCached)
            } catch {
                asSafeMarkdownAttributedString = AttributedString(
                    stringLiteral: htmlValue)
            }
        } else {
            asSafeMarkdownAttributedString = AttributedString(
                stringLiteral: htmlValue)
        }

        safeMarkdownAttributedStringWithoutNeoDBStatusCached =
            Self.makeSafeMarkdownAttributedStringWithoutNeoDBStatus(from: asMarkdown)
    }

    // MARK: - Convenience factory: parse from raw HTML like decoder
    public static func fromHTML(_ html: String) -> HTMLString {
        var result = HTMLString(stringValue: "")
        result.parseHTML(html)
        return result
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(htmlValue, forKey: .htmlValue)
        try container.encode(asMarkdown, forKey: .asMarkdown)
        try container.encode(asRawText, forKey: .asRawText)
        try container.encode(statusesURLs, forKey: .statusesURLs)
        try container.encode(links, forKey: .links)
        try container.encode(hadTrailingTags, forKey: .hadTrailingTags)
    }

    // MARK: - DRY HTML parsing pipeline used by decoder and factory
    private mutating func parseHTML(_ html: String) {
        htmlValue = html
        hadTrailingTags = false
        // Use cached regex instances
        main_regex = Self.mainRegexCached
        underscore_regex = Self.underscoreRegexCached
        statusesURLs = []
        asMarkdown = ""
        do {
            let document: Document = try SwiftSoup.parse(html)
            var listCounters: [Int] = []
            handleNode(node: document, listCounters: &listCounters)

            document.outputSettings(OutputSettings().prettyPrint(pretty: false))
            try document.select("p.quote-inline").remove()
            try document.select("br").after("\n")
            try document.select("p").after("\n\n")
            let htmlDoc = try document.html()
            var text = try SwiftSoup.clean(htmlDoc, "", Whitelist.none(), OutputSettings().prettyPrint(pretty: false)) ?? ""
            if text.hasSuffix("\n\n") {
                _ = text.removeLast(); _ = text.removeLast()
            }
            text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            asRawText = (try? Entities.unescape(text)) ?? text
            if asMarkdown.hasPrefix("\n") { _ = asMarkdown.removeFirst() }

            removeTrailingTags(doc: document)
        } catch {
            asRawText = html
        }
        do {
            asSafeMarkdownAttributedString = try AttributedString(
                markdown: asMarkdown.trimmingCharacters(in: .whitespacesAndNewlines),
                options: Self.markdownOptionsCached
            )
        } catch {
            asSafeMarkdownAttributedString = AttributedString(stringLiteral: html)
        }

        safeMarkdownAttributedStringWithoutNeoDBStatusCached =
            Self.makeSafeMarkdownAttributedStringWithoutNeoDBStatus(from: asMarkdown)
    }

    private mutating func removeTrailingTags(doc: Document) {
        if !asMarkdown.contains("#") { return }

        let paragraphs = asMarkdown.split(
            separator: "\n\n",
            omittingEmptySubsequences: false
        ).map(String.init)
        guard
            let lastIndex = paragraphs.lastIndex(where: {
                !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            })
        else {
            return
        }

        let isLastParagraphTagsOnly: Bool = {
            do {
                let paras = try doc.select("p:not(.quote-inline)")
                guard let lastP = paras.array().last else { return false }
                var hasAtLeastOneHashtag = false
                for child in lastP.getChildNodes() {
                    let name = child.nodeName()
                    if name == "#text" {
                        let txt = child.description.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !txt.isEmpty { return false }
                    } else if name == "a" {
                        let cls = (try? child.attr("class")) ?? ""
                        if !cls.contains("hashtag") { return false }
                        hasAtLeastOneHashtag = true
                    } else {
                        return false
                    }
                }
                return hasAtLeastOneHashtag
            } catch {
                return false
            }
        }()

        guard isLastParagraphTagsOnly else { return }

        hadTrailingTags = true
        let updatedMarkdownParagraphs = Array(paragraphs.prefix(lastIndex))
        asMarkdown = updatedMarkdownParagraphs.joined(separator: "\n\n")

        let rawParagraphs = asRawText.split(
            separator: "\n\n",
            omittingEmptySubsequences: false
        ).map(String.init)
        if lastIndex < rawParagraphs.count {
            let updatedRawParagraphs = Array(rawParagraphs.prefix(lastIndex))
            asRawText = updatedRawParagraphs.joined(separator: "\n\n")
        }
    }

    private mutating func handleNode(
        node: SwiftSoup.Node,
        indent: Int? = 0,
        skipParagraph: Bool = false,
        listCounters: inout [Int]
    ) {
        do {
            if let className = try? node.attr("class") {
                if className == "invisible" {
                    // don't display
                    return
                }

                if className == "ellipsis" {
                    // descend into this one now and
                    // append the ellipsis
                    for nn in node.getChildNodes() {
                        handleNode(
                            node: nn, indent: indent,
                            listCounters: &listCounters)
                    }
                    asMarkdown += "…"
                    return
                }
            }

            if node.nodeName() == "p" {
                if let className = try? node.attr("class"), className == "quote-inline" {
                    return
                }
                if asMarkdown.count > 0 && !skipParagraph {
                    asMarkdown += "\n\n"
                }
            } else if node.nodeName() == "br" {
                if asMarkdown.count > 0 {  // ignore first opening <br>
                    asMarkdown += "\n"
                }
                if (indent ?? 0) > 0 {
                    asMarkdown += "\n"
                }
            } else if node.nodeName() == "a" {
                let href = try node.attr("href")
                if href != "" {
                    if let url = URL(string: href) {
                        if Int(url.lastPathComponent) != nil {
                            statusesURLs.append(url)
                        } else if url.host() == "www.threads.net"
                            || url.host() == "threads.net",
                            url.pathComponents.count == 4,
                            url.pathComponents[2] == "post"
                        {
                            statusesURLs.append(url)
                        }
                    }
                }
                asMarkdown += "["
                let start = asMarkdown.endIndex
                // descend into this node now so we can wrap the
                // inner part of the link in the right markup
                for nn in node.getChildNodes() {
                    handleNode(node: nn, listCounters: &listCounters)
                }
                let finish = asMarkdown.endIndex

                var linkRef = href

                // Try creating a URL from the string. If it fails, try URL encoding
                //   the string first.
                var url = URL(string: href)
                if url == nil {
                    url = URL(string: href, encodePath: true)
                }
                if let linkUrl = url {
                    linkRef = linkUrl.absoluteString
                    let displayString = asMarkdown[start..<finish]
                    links.append(
                        Link(linkUrl, displayString: String(displayString)))
                }

                asMarkdown += "]("
                asMarkdown += linkRef
                asMarkdown += ")"

                return
            } else if node.nodeName() == "#text" {
                var txt = node.description

                txt = (try? Entities.unescape(txt)) ?? txt

                if let underscore_regex, let main_regex {
                    //  This is the markdown escaper
                    txt = main_regex.stringByReplacingMatches(
                        in: txt, options: [],
                        range: NSRange(location: 0, length: txt.count),
                        withTemplate: "\\\\$1")
                    txt = underscore_regex.stringByReplacingMatches(
                        in: txt, options: [],
                        range: NSRange(location: 0, length: txt.count),
                        withTemplate: "\\\\$1")
                }
                // Strip newlines and line separators - they should be being sent as <br>s
                asMarkdown += txt.replacingOccurrences(of: "\n", with: "")
                    .replacingOccurrences(
                        of: "\u{2028}", with: "")
            } else if node.nodeName() == "blockquote" {
                asMarkdown += "\n\n`"
                for nn in node.getChildNodes() {
                    handleNode(
                        node: nn, indent: indent, listCounters: &listCounters)
                }
                asMarkdown += "`"
                return
            } else if node.nodeName() == "strong" || node.nodeName() == "b" {
                asMarkdown += "**"
                for nn in node.getChildNodes() {
                    handleNode(
                        node: nn, indent: indent, listCounters: &listCounters)
                }
                asMarkdown += "**"
                return
            } else if node.nodeName() == "em" || node.nodeName() == "i" {
                asMarkdown += "_"
                for nn in node.getChildNodes() {
                    handleNode(
                        node: nn, indent: indent, listCounters: &listCounters)
                }
                asMarkdown += "_"
                return
            } else if node.nodeName() == "ul" || node.nodeName() == "ol" {

                if skipParagraph {
                    asMarkdown += "\n"
                } else {
                    asMarkdown += "\n\n"
                }

                var listCounters = listCounters

                if node.nodeName() == "ol" {
                    listCounters.append(1)  // Start numbering for a new ordered list
                }

                for nn in node.getChildNodes() {
                    handleNode(
                        node: nn, indent: (indent ?? 0) + 1,
                        listCounters: &listCounters)
                }

                if node.nodeName() == "ol" {
                    listCounters.removeLast()
                }

                return
            } else if node.nodeName() == "li" {
                asMarkdown += "   "
                if let indent, indent > 1 {
                    for _ in 0..<indent {
                        asMarkdown += "   "
                    }
                    asMarkdown += "- "
                }

                if listCounters.isEmpty {
                    asMarkdown += "• "
                } else {
                    let currentIndex = listCounters.count - 1
                    asMarkdown += "\(listCounters[currentIndex]). "
                    listCounters[currentIndex] += 1
                }

                for nn in node.getChildNodes() {
                    handleNode(
                        node: nn, indent: indent, skipParagraph: true,
                        listCounters: &listCounters)
                }
                asMarkdown += "\n"
                return
            }

            for n in node.getChildNodes() {
                handleNode(node: n, indent: indent, listCounters: &listCounters)
            }
        } catch {}
    }

    public struct Link: Codable, Hashable, Identifiable {
        public var id: Int { hashValue }
        public let url: URL
        public let displayString: String
        public let type: LinkType
        public let title: String
        public let neodbItem: (any ItemProtocol)?

        public init(_ url: URL, displayString: String) {
            self.url = url
            self.displayString = displayString
            
            // Try to parse NeoDB item first
            self.neodbItem = NeoDBURL.parseItemURL(url, title: displayString)
            
            switch displayString.first {
            case "@":
                type = .mention
                title = displayString
            case "#":
                type = .hashtag
                title = String(displayString.dropFirst())
            default:
                type = .url
                var hostNameUrl = url.host ?? url.absoluteString
                if hostNameUrl.hasPrefix("www.") {
                    hostNameUrl = String(hostNameUrl.dropFirst(4))
                }
                title = hostNameUrl
            }
        }
        
        // MARK: - Codable
        private enum CodingKeys: String, CodingKey {
            case url, displayString, type, title
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            url = try container.decode(URL.self, forKey: .url)
            displayString = try container.decode(String.self, forKey: .displayString)
            type = try container.decode(LinkType.self, forKey: .type)
            title = try container.decode(String.self, forKey: .title)
            neodbItem = NeoDBURL.parseItemURL(url, title: displayString)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(url, forKey: .url)
            try container.encode(displayString, forKey: .displayString)
            try container.encode(type, forKey: .type)
            try container.encode(title, forKey: .title)
        }

        // MARK: - Hashable
        public func hash(into hasher: inout Hasher) {
            hasher.combine(url)
            hasher.combine(displayString)
            hasher.combine(type)
            hasher.combine(title)
        }

        public static func == (lhs: Link, rhs: Link) -> Bool {
            lhs.url == rhs.url &&
            lhs.displayString == rhs.displayString &&
            lhs.type == rhs.type &&
            lhs.title == rhs.title
        }

        public enum LinkType: String, Codable {
            case url
            case mention
            case hashtag
        }
    }
}

public extension URL {
    // It's common to use non-ASCII characters in URLs even though they're technically
    //   invalid characters. Every modern browser handles this by silently encoding
    //   the invalid characters on the user's behalf. However, trying to create a URL
    //   object with un-encoded characters will result in nil so we need to encode the
    //   invalid characters before creating the URL object. The unencoded version
    //   should still be shown in the displayed status.
    init?(string: String, encodePath: Bool) {
        var encodedUrlString = ""
        if encodePath,
            string.starts(with: "http://") || string.starts(with: "https://"),
            var startIndex = string.firstIndex(of: "/")
        {
            startIndex = string.index(startIndex, offsetBy: 1)

            // We don't want to encode the host portion of the URL
            if var startIndex = string[startIndex...].firstIndex(of: "/") {
                encodedUrlString = String(string[...startIndex])
                while let endIndex = string[string.index(after: startIndex)...]
                    .firstIndex(of: "/")
                {
                    let componentStartIndex = string.index(after: startIndex)
                    encodedUrlString =
                        encodedUrlString
                        + (string[componentStartIndex...endIndex]
                            .addingPercentEncoding(
                                withAllowedCharacters: .urlPathAllowed) ?? "")
                    startIndex = endIndex
                }

                // The last part of the path may have a query string appended to it
                let componentStartIndex = string.index(after: startIndex)
                if let queryStartIndex = string[componentStartIndex...]
                    .firstIndex(of: "?")
                {
                    encodedUrlString =
                        encodedUrlString
                        + (string[componentStartIndex..<queryStartIndex]
                            .addingPercentEncoding(
                                withAllowedCharacters: .urlPathAllowed) ?? "")
                    encodedUrlString =
                        encodedUrlString
                        + (string[queryStartIndex...].addingPercentEncoding(
                            withAllowedCharacters: .urlQueryAllowed) ?? "")
                } else {
                    encodedUrlString =
                        encodedUrlString
                        + (string[componentStartIndex...].addingPercentEncoding(
                            withAllowedCharacters: .urlPathAllowed) ?? "")
                }
            }
        }
        if encodedUrlString.isEmpty {
            encodedUrlString = string
        }
        self.init(string: encodedUrlString)
    }
}
