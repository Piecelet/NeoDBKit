//
//  NeoDBAccountLoginEndpoint.swift
//  NeoDBKit
//
//  Created by citron on 1/23/25.
//

import Foundation

public enum NeoDBAccountLoginEndpoint {
    case login
    case mastodon(referer: URL, cookie: String, csrfmiddlewaretoken: String, instance: String)
}

extension NeoDBAccountLoginEndpoint: NetworkEndpoint {
    public var type: EndpointType { .raw }

    public var path: String {
        switch self {
        case .login:
            return "/account/login"
        case .mastodon:
            return "/account/mastodon/login"
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .mastodon(let referer, _, _, _):
            return [
                "Origin": referer.host ?? "",
                "Referer": referer.absoluteString,
//                "Cookie": cookie,
//                "User-Agent": AppConfig.OAuth.userAgent,
            ]
        default:
            return nil
        }
    }

    public var queryItems: [URLQueryItem]? {
        switch self {
        case .mastodon(_, _, let csrfmiddlewaretoken, let instance):
            return [
                .init(name: "csrfmiddlewaretoken", value: csrfmiddlewaretoken),
                .init(name: "method", value: "mastodon"),
                .init(name: "domain", value: instance)
            ]
        default:
            return nil
        }
    }

    public var responseType: ResponseType { .html }
}

