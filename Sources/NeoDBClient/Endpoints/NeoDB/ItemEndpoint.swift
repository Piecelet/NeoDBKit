//
//  ItemEndpoint.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import Foundation
import NeoDBModels

public enum ItemEndpoint {
    case book(uuid: ItemUUID)
    case movie(uuid: ItemUUID)
    case tv(uuid: ItemUUID, isSeason: Bool = false, isEpisode: Bool = false)
    case podcast(uuid: ItemUUID, isEpisode: Bool = false)
    case album(uuid: ItemUUID)
    case game(uuid: ItemUUID)
    case performance(uuid: ItemUUID, isProduction: Bool = false)
    case post(uuid: ItemUUID, types: [ItemPostType], page: Int = 1)
}

extension ItemEndpoint {
    public static func make(id: ItemID, category: ItemCategory) -> ItemEndpoint {
//        let uuid = id.components(separatedBy: "/").last ?? id
        let uuid = id.uuid
        return .make(UUID: uuid, category: category)
    }

    public static func make(item: any ItemProtocol) -> ItemEndpoint {
        return .make(UUID: item.uuid, category: item.category)
    }

    public static func make(UUID itemUUID: ItemUUID, category itemCategory: ItemCategory) -> ItemEndpoint {
        return .make(uuid: itemUUID, type: itemCategory.type)
    }

    public static func make(uuid: ItemUUID, type: ItemType) -> ItemEndpoint {
        switch type {
        case .book:
            return .book(uuid: uuid)
        case .movie:
            return .movie(uuid: uuid)
        case .tv:
            return .tv(uuid: uuid, isSeason: false, isEpisode: false)
        case .tvSeason:
            return .tv(uuid: uuid, isSeason: true, isEpisode: false)
        case .tvEpisode:
            return .tv(uuid: uuid, isSeason: false, isEpisode: true)
        case .music:
            return .album(uuid: uuid)
        case .game:
            return .game(uuid: uuid)
        case .podcast:
            return .podcast(uuid: uuid, isEpisode: false)
        case .podcastEpisode:
            return .podcast(uuid: uuid, isEpisode: true)
        case .performance:
            return .performance(uuid: uuid, isProduction: false)
        case .performanceProduction:
            return .performance(uuid: uuid, isProduction: true)
        default:
            return .book(uuid: uuid) // Fallback to book for unsupported types
        }
    }
}

extension ItemEndpoint: NetworkEndpoint {
    public var path: String {
        switch self {
        case .book(let uuid):
            return "/book/\(uuid)"
        case .movie(let uuid):
            return "/movie/\(uuid)"
        case .tv(let uuid, let isSeason, let isEpisode):
            if isSeason {
                return "/tv/season/\(uuid)"
            } else if isEpisode {
                return "/tv/episode/\(uuid)"
            } else {
                return "/tv/\(uuid)"
            }
        case .podcast(let uuid, let isEpisode):
            if isEpisode {
                return "/podcast/episode/\(uuid)"
            } else {
                return "/podcast/\(uuid)"
            }
        case .album(let uuid):
            return "/album/\(uuid)"
        case .game(let uuid):
            return "/game/\(uuid)"
        case .performance(let uuid, let isProduction):
            if isProduction {
                return "/performance/production/\(uuid)"
            } else {
                return "/performance/\(uuid)"
            }
        case .post(let uuid, _, _):
            return "/item/\(uuid)/posts/"
        }
    }

    public var queryItems: [URLQueryItem]? {
        switch self {
        case .post(_, let types, let page):
            return [
                .init(name: "type", value: types.map { $0.rawValue }.joined(separator: ",")),
                .init(name: "page", value: String(page)),
            ]
        default:
            return nil
        }
    }
}
