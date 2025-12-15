//
//  NetworkEndpoint.swift
//  NeoDB
//
//  Created by citron on 1/13/25.
//

import Foundation

public enum ContentType {
    case json
    case urlEncoded

    public var headerValue: String {
        switch self {
        case .json:
            return "application/json"
        case .urlEncoded:
            return "application/x-www-form-urlencoded"
        }
    }
}

public enum HostType {
    case currentInstance
    case custom(String)
}

public enum PieceletServiceHost {
    case neodbPublicApi
    case api
    case apiRelay
}

public enum EndpointType {
    case oauth
    case api
    case apiV1
    case apiV2
    case raw
}

public enum ResponseType {
    case json
    case html
}

public protocol NetworkEndpoint {
    var host: HostType { get }
    var type: EndpointType { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var bodyJson: Encodable? { get }
    var bodyUrlEncoded: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
}

extension NetworkEndpoint {
    public var host: HostType {
        return .currentInstance
    }

    public var type: EndpointType {
        return .api
    }

    public var method: HTTPMethod {
        return .get
    }

    public var queryItems: [URLQueryItem]? {
        return nil
    }

    public var bodyJson: Encodable? {
        return nil
    }

    public var bodyUrlEncoded: [URLQueryItem]? {
        return nil
    }

    public var headers: [String: String]? {
        return nil
    }
}

extension NetworkEndpoint {
    public func makePaginationParam(
        sinceId: String?,
        maxId: String?,
        mindId: String?
    ) -> [URLQueryItem]? {
        var params: [URLQueryItem] = []

        if let sinceId {
            params.append(.init(name: "since_id", value: sinceId))
        }
        if let maxId {
            params.append(.init(name: "max_id", value: maxId))
        }
        if let mindId {
            params.append(.init(name: "min_id", value: mindId))
        }

        return params.isEmpty ? nil : params
    }
}
