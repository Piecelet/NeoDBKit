import Foundation
import OSLog
import NeoDBModels

public struct RequestBuilder {
    private let logger = NetworkLogger.core
    public let instance: String
    public let encoder: JSONEncoder

    public init(instance: String, encoder: JSONEncoder = Self.makeDefaultEncoder()) {
        self.instance = instance
        self.encoder = encoder
    }

    public func makeRequest(for endpoint: NetworkEndpoint, scheme: String = "https") throws -> URLRequest {
        let url = try makeURL(for: endpoint, scheme: scheme)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 10

        if let bodyJson = endpoint.bodyJson {
            request.setValue(
                ContentType.json.headerValue,
                forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = try encoder.encode(bodyJson)
        } else if let bodyUrlEncoded = endpoint.bodyUrlEncoded {
            request.setValue(
                ContentType.urlEncoded.headerValue,
                forHTTPHeaderField: "Content-Type"
            )
            let items = bodyUrlEncoded.compactMap { item in
                item.value.map { URLQueryItem(name: item.name, value: $0) }
            }
            if !items.isEmpty {
                request.httpBody = items
                    .map { "\($0.name)=\($0.value ?? "")" }
                    .joined(separator: "&")
                    .data(using: .utf8)
            }
        }

        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    public func makeURL(for endpoint: NetworkEndpoint, scheme: String = "https") throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = instance

        switch endpoint.host {
        case .currentInstance:
            components.host = instance
        case .custom(let host):
            components.host = host
        }

        var path = endpoint.path
        switch endpoint.type {
        case .apiV1:
            path = "/api/v1" + path
        case .apiV2:
            path = "/api/v2" + path
        case .api:
            path = "/api" + path
        case .oauth:
            path = "/oauth" + path
        case .raw:
            break
        }
        components.path = path

        if let queryItems = endpoint.queryItems?.compactMap({ item in
            item.value.map { URLQueryItem(name: item.name, value: $0) }
        }), !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            logger.error("Failed to construct URL for endpoint: \(endpoint.path)")
            throw NetworkError.invalidURL
        }

        if Self.isPlaceholderURL(url) {
            logger.info("Not requesting placeholder URL: \(url.absoluteString)")
            throw NetworkError.invalidURL
        }

        if url.host?.contains("piecelet.internal") == true
            || url.host?.contains("neodb.internal") == true
        {
            logger.info("Not requesting internal URL: \(url.absoluteString)")
            throw NetworkError.invalidURL
        }
        return url
    }

    public static func makeDefaultEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    private static func isPlaceholderURL(_ url: URL?) -> Bool {
        return Placeholders.isPlaceholderURL(url)
    }

    // private static let placeholderIndicators: [String] = [
    //     "neodb.internal/placeholder",
    //     "piecelet.internal/placeholder",
    //     "fjords-banner-600.fa337a5055b6.jpg"
    // ]
}
