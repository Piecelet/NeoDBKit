//
//  CatalogEndpoint.swift
//  NeoDBKit
//
//  Created by citron on 1/15/25.
//

import Foundation
import NeoDBModels

public enum CatalogEndpoint {
    case search(query: String, category: ItemCategory? = nil, page: Int? = nil)
    case fetch(url: URL)
    @available(*, deprecated, message: "Use trending from TrendingEndpoint with TrendingItemResult instead.")
    case gallery
}

extension CatalogEndpoint: NetworkEndpoint {
    public var path: String {
        switch self {
        case .search:
            return "/catalog/search"
        case .fetch:
            return "/catalog/fetch"
        case .gallery:
            return "/catalog/gallery/"
        }
    }

    public var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let query, let category, let page):
            var items: [URLQueryItem] = [
                .init(name: "query", value: query),
            ]
            
            if let category = category {
                items.append(.init(name: "category", value: category.rawValue))
            }
            
            if let page = page {
                items.append(.init(name: "page", value: page.description))
            }
            
            return items
        case .fetch(let url):
            return [
                .init(name: "url", value: url.absoluteString)
            ]
        case .gallery:
            return nil
        }
    }
}
