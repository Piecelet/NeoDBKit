//
//  AppsEndpoint.swift
//  NeoDBKit
//
//  Created by citron on 1/13/25.
//

import Foundation

/// OAuth app registration endpoint for NeoDB-compatible instances.
///
/// This endpoint registers a client application and returns credentials
/// that can be used for subsequent OAuth flows.
public enum AppsEndpoint {
    /// Registers a new client application.
    /// - Parameters:
    ///   - clientName: Human-readable application name.
    ///   - redirectUri: OAuth redirect URI.
    ///   - scopes: Space-separated list of OAuth scopes.
    ///   - website: Optional application website.
    case create(
        clientName: String,
        redirectUri: String,
        scopes: String,
        website: String
    )
}

extension AppsEndpoint: NetworkEndpoint {
    public var type: EndpointType { .apiV1 }

    public var path: String {
        switch self {
        case .create:
            return "/apps"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        }
    }

    public var bodyUrlEncoded: [URLQueryItem]? {
        switch self {
        case let .create(clientName, redirectUri, scopes, website):
            return [
                .init(name: "client_name", value: clientName),
                .init(name: "redirect_uris", value: redirectUri),
                .init(name: "scopes", value: scopes),
                .init(name: "website", value: website),
            ]
        }
    }
}

