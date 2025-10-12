//
//  ItemType.swift
//  Live Capture
//
//  Created by 甜檸Citron(lcandy2) on 2/1/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

public enum ItemType: String, Codable, Sendable, CaseIterable {
    case book = "edition"
    case movie
    case tv = "tvshow"
    case tvSeason = "TVSeason"
    case tvEpisode = "TVEpisode"
    case music
    case podcast
    case podcastEpisode = "podcastepisode"
    case game = "Game"
    case performance = "Performance"
    case performanceProduction = "PerformanceProduction"
    case unknown
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawString = try container.decode(String.self)
        
        // 尝试直接匹配
        if let type = ItemType(rawValue: rawString) {
            self = type
            return
        }
        
        // 尝试小写匹配
        let lowercased = rawString.lowercased()
        if let type = ItemType.allCases.first(where: { $0.rawValue.lowercased() == lowercased }) {
            self = type
            return
        }
        
        // 如果都匹配失败，使用原始字符串作为 book 类型
        self = .unknown
    }
}

extension ItemType {
    public var category: ItemCategory? {
        switch self {
        case .book:
            return .book
        case .movie:
            return .movie
        case .tv, .tvSeason, .tvEpisode:
            return .tv
        case .music:
            return .music
        case .podcast, .podcastEpisode:
            return .podcast
        case .game:
            return .game
        case .performance, .performanceProduction:
            return .performance
        case .unknown:
            return nil
        }
    }
}
