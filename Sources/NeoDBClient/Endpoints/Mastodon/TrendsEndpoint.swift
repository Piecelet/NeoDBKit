//
//  TrendsEndpoint.swift
//  NeoDBKit
//
//  Created by citron on 1/22/25.
//

import Foundation

public enum TrendsEndpoint {
    case tags(limit: Int = 10, offset: Int? = nil)
    case statuses(limit: Int = 10, offset: Int? = nil)
    case links(limit: Int = 10, offset: Int? = nil)
}

extension TrendsEndpoint: NetworkEndpoint {
    public var type: EndpointType { .apiV1 }
    
    public var path: String {
        switch self {
        case .tags:
            return "/trends/tags"
        case .statuses:
            return "/trends/statuses"
        case .links:
            return "/trends/links"
        }
    }

    public var queryItems: [URLQueryItem]? {
        switch self {
        case let .links(limit, offset), let .statuses(limit, offset), let .tags(limit, offset):
            var items = [URLQueryItem]()
            items.append(URLQueryItem(name: "limit", value: String(limit)))
            if let offset {
                items.append(URLQueryItem(name: "offset", value: String(offset)))
            }
            return items
        }
    }
}
