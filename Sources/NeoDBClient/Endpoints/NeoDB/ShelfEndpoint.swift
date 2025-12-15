//
//  ShelfEndpoint.swift
//  NeoDBKit
//
//  Created by citron on 1/15/25.
//

import Foundation
import NeoDBModels

public enum ShelfEndpoint {
    case get(type: ShelfType, category: ItemCategory.shelfAvailable? = nil, page: Int? = 1, pageSize: Int? = nil)
    case getUser(handle: String, type: ShelfType, category: ItemCategory.shelfAvailable? = nil, page: Int? = 1, pageSize: Int? = nil)
}

extension ShelfEndpoint: NetworkEndpoint {
    public var path: String {
        switch self {
        case .get(let type, _, _, _):
            return "/me/shelf/\(type.rawValue)"
        case .getUser(let handle, let type, _, _, _):
            return "/user/\(handle)/shelf/\(type.rawValue)"
        }
    }

    public var queryItems: [URLQueryItem]? {
        switch self {
        case .get(_, let category, let page, let pageSize):
            var items: [URLQueryItem] = []
            
            if let category = category, category != .allItems {
                items.append(.init(name: "category", value: category.rawValue))
            }
            
            if let page = page {
                items.append(.init(name: "page", value: String(page)))
            }

            if let pageSize = pageSize {
                items.append(.init(name: "page_size", value: String(pageSize)))
            }
            
            return items.isEmpty ? nil : items
        case .getUser(_, let type, let category, let page, let pageSize):
            var items: [URLQueryItem] = []

            if let category = category, category != .allItems {
                items.append(.init(name: "category", value: category.rawValue))
            }

            if let page = page {
                items.append(.init(name: "page", value: String(page)))
            }

            if let pageSize = pageSize {
                items.append(.init(name: "page_size", value: String(pageSize)))
            }

            return items.isEmpty ? nil : items
        }
    }
}
