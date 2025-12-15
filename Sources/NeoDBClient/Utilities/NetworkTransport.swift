//
//  NetworkTransport.swift
//  NeoDB
//
//  Created by OpenAI Assistant on 3/2/25.
//

import Foundation

public protocol NetworkTransport {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
    func webSocketTask(for request: URLRequest) -> URLSessionWebSocketTask
    func upload(
        for request: URLRequest,
        from bodyData: Data,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

public struct URLSessionTransport: NetworkTransport {
    public let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }

    public func webSocketTask(for request: URLRequest) -> URLSessionWebSocketTask {
        session.webSocketTask(with: request)
    }

    public func upload(
        for request: URLRequest,
        from bodyData: Data,
        delegate: (any URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        try await session.upload(for: request, from: bodyData, delegate: delegate)
    }
}
