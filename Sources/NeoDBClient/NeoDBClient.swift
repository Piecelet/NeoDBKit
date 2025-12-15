import Foundation
import OSLog
@_exported import NeoDBModels

public enum NetworkError: LocalizedError, Sendable {
    case invalidURL
    case unauthorized
    case invalidResponse
    case httpError(code: Int, message: String? = nil)
    case decodingError(Error)
    case messageError(String)
    case networkError(Error)
    case cancelled
    case authenticationRequired(message: String? = nil)
    case reauthenticationRequired(message: String? = nil)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .unauthorized:
            return "Unauthorized"
        case .invalidResponse:
            return "Invalid response"
        case .httpError(let code, let message):
            if let message = message {
                return "HTTP \(code): \(message)"
            }
            return "HTTP error: \(code)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .cancelled:
            return "Request cancelled"
        case .messageError(let message):
            return message
        case .authenticationRequired(let message):
            if let message {
                return message
            }
            return String(
                localized: "network_error_authentication_required",
                defaultValue: "Please sign in to use this feature.",
                table: "Settings"
            )
        case .reauthenticationRequired(let message):
            if let message {
                return message
            }
            return String(
                localized: "network_error_reauthentication_required",
                defaultValue: "Your session has expired. Please sign in again.",
                table: "Settings"
            )
        }
    }

    public var failureReason: String? {
        switch self {
        case .decodingError(let error):
            return error.localizedDescription
        case .networkError(let error):
            return error.localizedDescription
        case .httpError(let code, let message):
            if let message = message {
                return "Server returned error: \(message)"
            }
            return "Server returned status code: \(code)"
        case .messageError(let message):
            return "Server returned error: \(message)"
        case .authenticationRequired(let message), .reauthenticationRequired(let message):
            return message
        default:
            return nil
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .invalidURL:
            return "Please check the URL is correct"
        case .unauthorized:
            return "Please try logging in again"
        case .httpError(let code, _):
            if code == 404 {
                return "The requested resource was not found"
            } else if code >= 500 {
                return "Please try again later"
            }
            return nil
        case .authenticationRequired:
            return String(
                localized: "network_error_authentication_required_recovery",
                defaultValue: "Open the Accounts tab to sign in.",
                table: "Settings"
            )
        case .reauthenticationRequired:
            return String(
                localized: "network_error_reauthentication_required_recovery",
                defaultValue: "Sign out and sign back in to refresh your credentials.",
                table: "Settings"
            )
        default:
            return nil
        }
    }
}

extension NetworkError {
    public var isReauthenticationRelated: Bool {
        if case .reauthenticationRequired = self {
            return true
        }
        return false
    }

    public var isAuthenticationMissing: Bool {
        if case .authenticationRequired = self {
            return true
        }
        return false
    }
}

public final class NeoDBClient: @unchecked Sendable {
    private struct Critical: Sendable {
        var lastResponse: HTTPURLResponse?
    }

    private let logger = NetworkLogger.core
    private let transport: NetworkTransport
    private let requestBuilder: RequestBuilder
    private let authenticator: NetworkAuthenticating
    private let responseHandler: ResponseHandler
    private let critical: OSAllocatedUnfairLock<Critical>

    private static let isDebugRequestEnabled: Bool = true
    private static let isDebugResponseEnabled: Bool = false

    public let instance: String
    /// App-provided identifier (e.g. AppAccount.storageKey) used for diagnostics/logging only.
    /// This value is not sent over the network.
    public let storageKey: String

    public var currentToken: OauthToken? {
        get { authenticator.token }
        set { authenticator.token = newValue }
    }

    public var lastResponse: HTTPURLResponse? {
        get { critical.withLock { $0.lastResponse } }
        set { critical.withLock { $0.lastResponse = newValue } }
    }

    public func makeURL(endpoint: NetworkEndpoint, scheme: String = "https") throws -> URL {
        try requestBuilder.makeURL(for: endpoint, scheme: scheme)
    }

    public func makeRequest(for endpoint: NetworkEndpoint, scheme: String = "https") throws -> URLRequest {
        var request = try requestBuilder.makeRequest(for: endpoint, scheme: scheme)
        authenticator.applyAuthentication(to: &request)
        return request
    }

    public init(
        instance: String,
        oauthToken: OauthToken? = nil,
        transport: NetworkTransport = URLSessionTransport(),
        requestBuilder: RequestBuilder? = nil,
        authenticator: NetworkAuthenticating? = nil,
        responseHandler: ResponseHandler? = nil,
        storageKey: String = "piecelet.internal:unknown"
    ) {
        self.instance = instance
        self.storageKey = storageKey
        self.transport = transport
        self.requestBuilder = requestBuilder ?? RequestBuilder(instance: instance)
        self.authenticator = authenticator ?? DefaultAuthenticator(token: oauthToken)
        self.responseHandler = responseHandler ?? ResponseHandler()
        self.critical = OSAllocatedUnfairLock(initialState: Critical(lastResponse: nil))
    }

    public func fetch<T: Decodable>(_ endpoint: NetworkEndpoint, type: T.Type)
        async throws -> T
    {
        let (data, _) = try await performRequest(for: endpoint)
        return try responseHandler.decode(type, from: data, endpoint: endpoint)
    }

    public func fetchWithPagination<T: Decodable>(
        _ endpoint: NetworkEndpoint,
        type: T.Type
    ) async throws -> (T, LinkPagination?) {
        let (data, httpResponse) = try await performRequest(for: endpoint)
        let pagination = parsePagination(from: httpResponse)
        return (
            try responseHandler.decode(type, from: data, endpoint: endpoint),
            pagination
        )
    }

    // MARK: - Convenience HTTP wrappers

    public func get<T: Decodable>(_ endpoint: NetworkEndpoint, type: T.Type) async throws -> T {
        try await fetch(endpoint, type: type)
    }

    public func get<T: Decodable>(_ endpoint: NetworkEndpoint) async throws -> T {
        try await fetch(endpoint, type: T.self)
    }

    public func getWithPagination<T: Decodable>(_ endpoint: NetworkEndpoint) async throws
        -> (T, LinkPagination?)
    {
        try await fetchWithPagination(endpoint, type: T.self)
    }

    public func post<T: Decodable>(_ endpoint: NetworkEndpoint, type: T.Type) async throws -> T {
        try await fetch(endpoint, type: type)
    }

    public func post(_ endpoint: NetworkEndpoint) async throws -> HTTPURLResponse {
        try await sendForResponse(endpoint)
    }

    public func put<T: Decodable>(_ endpoint: NetworkEndpoint, type: T.Type) async throws -> T {
        try await fetch(endpoint, type: type)
    }

    public func put(_ endpoint: NetworkEndpoint) async throws -> HTTPURLResponse {
        try await sendForResponse(endpoint)
    }

    public func patch<T: Decodable>(_ endpoint: NetworkEndpoint, type: T.Type) async throws -> T {
        try await fetch(endpoint, type: type)
    }

    public func patch(_ endpoint: NetworkEndpoint) async throws -> HTTPURLResponse {
        try await sendForResponse(endpoint)
    }

    public func delete<T: Decodable>(_ endpoint: NetworkEndpoint, type: T.Type) async throws -> T {
        try await fetch(endpoint, type: type)
    }

    public func delete(_ endpoint: NetworkEndpoint) async throws -> HTTPURLResponse {
        try await sendForResponse(endpoint)
    }

    public func send(_ endpoint: NetworkEndpoint) async throws {
        _ = try await performRequest(for: endpoint)
    }

    public func sendForResponse(_ endpoint: NetworkEndpoint) async throws -> HTTPURLResponse {
        let (_, response) = try await performRequest(for: endpoint)
        return response
    }

    public func makeWebSocketTask(
        endpoint: NetworkEndpoint,
        customHost: String? = nil,
        includeAuthSubprotocol: Bool = true
    ) throws
        -> URLSessionWebSocketTask
    {
        var request = try requestBuilder.makeRequest(for: endpoint, scheme: "wss")
        if let customHost, let originalURL = request.url,
           var components = URLComponents(url: originalURL, resolvingAgainstBaseURL: false) {
            components.host = customHost
            request.url = components.url
        }
        authenticator.applyAuthentication(to: &request)
        if includeAuthSubprotocol, let token = authenticator.token?.accessToken {
            request.setValue(token, forHTTPHeaderField: "Sec-WebSocket-Protocol")
        }
        logger.debug("Creating WebSocket connection to: \(request.url?.absoluteString ?? "")")
        return transport.webSocketTask(for: request)
    }

    private func logRequest(_ request: URLRequest) {
        if !Self.isDebugRequestEnabled { return }
        let loggerRequest = NetworkLogger.request
        if !storageKey.isEmpty {
            loggerRequest.debug("Client storageKey: \(self.storageKey)")
        }
        loggerRequest.debug(
            "🌐 REQUEST [\(request.httpMethod ?? "Unknown")] \(request.url?.absoluteString ?? "")"
        )
        if let headers = request.allHTTPHeaderFieldsSafe {
            loggerRequest.debug("Headers: \(headers)")
        }
        if let body = request.httpBody,
            let bodyString = String(data: body, encoding: .utf8)
        {
            loggerRequest.debug("Body: \(bodyString)")
        }
    }

    private func logResponse(_ response: URLResponse, data: Data) {
        if !Self.isDebugResponseEnabled { return }
        let loggerResponse = NetworkLogger.response
        guard let httpResponse = response as? HTTPURLResponse else { return }
        if !storageKey.isEmpty {
            loggerResponse.debug("Client storageKey: \(self.storageKey)")
        }
        loggerResponse.debug(
            "📥 RESPONSE [\(httpResponse.statusCode)] \(httpResponse.url?.absoluteString ?? "")"
        )
        if let headers = httpResponse.allHeaderFields as? [String: String] {
            loggerResponse.debug("Headers: \(headers)")
        }
        if let bodyString = String(data: data, encoding: .utf8) {
            loggerResponse.debug("Body: \(bodyString)")
        }
    }

    private func performRequest(for endpoint: NetworkEndpoint, scheme: String = "https")
        async throws -> (Data, HTTPURLResponse)
    {
        var request = try requestBuilder.makeRequest(for: endpoint, scheme: scheme)
        authenticator.applyAuthentication(to: &request)
        logRequest(request)

        do {
            let (data, response) = try await transport.data(for: request)
            logResponse(response, data: data)

            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("Invalid response type")
                throw NetworkError.invalidResponse
            }

            critical.withLock { $0.lastResponse = httpResponse }

            let message = responseHandler.decodeServerMessage(from: data)
            try authenticator.validate(response: httpResponse, message: message)
            _ = try responseHandler.validate(response: httpResponse, data: data)

            return (data, httpResponse)
        } catch let error as NetworkError {
            throw error
        } catch let error as URLError {
            if error.code == .cancelled {
                logger.debug("Request cancelled")
                throw NetworkError.cancelled
            }
            logger.error("Network error: \(error.localizedDescription)")
            throw NetworkError.networkError(error)
        } catch {
            logger.error("Network error: \(error.localizedDescription)")
            throw NetworkError.networkError(error)
        }
    }

    public func sendWithoutFollowingRedirects(
        _ endpoint: NetworkEndpoint,
        scheme: String = "https"
    ) async throws -> (Data, HTTPURLResponse) {
        var request = try requestBuilder.makeRequest(for: endpoint, scheme: scheme)
        authenticator.applyAuthentication(to: &request)
        logRequest(request)

        let session: URLSession
        if let transport = transport as? URLSessionTransport {
            session = transport.session
        } else {
            session = .shared
        }

        do {
            let redirectDelegate = RedirectDisablingDelegate()
            let (data, response) = try await session.data(for: request, delegate: redirectDelegate)
            logResponse(response, data: data)

            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("Invalid response type")
                throw NetworkError.invalidResponse
            }

            critical.withLock { $0.lastResponse = httpResponse }

            let message = responseHandler.decodeServerMessage(from: data)
            try authenticator.validate(response: httpResponse, message: message)

            return (data, httpResponse)
        } catch let error as NetworkError {
            throw error
        } catch let error as URLError {
            if error.code == .cancelled {
                logger.debug("Request cancelled")
                throw NetworkError.cancelled
            }
            logger.error("Network error: \(error.localizedDescription)")
            throw NetworkError.networkError(error)
        } catch {
            logger.error("Network error: \(error.localizedDescription)")
            throw NetworkError.networkError(error)
        }
    }

    private func parsePagination(from response: HTTPURLResponse) -> LinkPagination? {
        guard
            let linkValue = response.allHeaderFields.first(where: { key, _ in
                (key as? String)?.lowercased() == "link"
            })?.value as? String
        else {
            return nil
        }
        return LinkPagination.parse(from: linkValue)
    }

    // MARK: - Multipart uploads

    public func uploadMultipart<T: Decodable>(
        _ endpoint: NetworkEndpoint,
        fileName: String,
        data: Data,
        mimeType: String,
        formFieldName: String = "file",
        progressHandler: (@Sendable (Double) -> Void)? = nil
    ) async throws -> T {
        let (responseData, _) = try await performMultipart(
            endpoint: endpoint,
            fileName: fileName,
            data: data,
            mimeType: mimeType,
            formFieldName: formFieldName,
            progressHandler: progressHandler)
        return try responseHandler.decode(T.self, from: responseData, endpoint: endpoint)
    }

    public func uploadMultipart(
        _ endpoint: NetworkEndpoint,
        fileName: String,
        data: Data,
        mimeType: String,
        formFieldName: String = "file",
        progressHandler: (@Sendable (Double) -> Void)? = nil
    ) async throws -> HTTPURLResponse {
        let (_, response) = try await performMultipart(
            endpoint: endpoint,
            fileName: fileName,
            data: data,
            mimeType: mimeType,
            formFieldName: formFieldName,
            progressHandler: progressHandler)
        return response
    }

    private func performMultipart(
        endpoint: NetworkEndpoint,
        fileName: String,
        data: Data,
        mimeType: String,
        formFieldName: String,
        progressHandler: (@Sendable (Double) -> Void)?
    ) async throws -> (Data, HTTPURLResponse) {
        var request = try requestBuilder.makeRequest(for: endpoint)
        let boundary = UUID().uuidString
        request.setValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )
        request.httpBody = makeMultipartBody(
            boundary: boundary,
            formFieldName: formFieldName,
            fileName: fileName,
            data: data,
            mimeType: mimeType
        )
        authenticator.applyAuthentication(to: &request)

        return try await performUpload(
            with: request,
            bodyData: request.httpBody ?? Data(),
            progressHandler: progressHandler
        )
    }

    private func makeMultipartBody(
        boundary: String,
        formFieldName: String,
        fileName: String,
        data: Data,
        mimeType: String
    ) -> Data {
        var body = Data()
        let lineBreak = "\r\n"
        body.append("--\(boundary)\(lineBreak)".data(using: .utf8)!)
        body.append(
            "Content-Disposition: form-data; name=\"\(formFieldName)\"; filename=\"\(fileName)\"\(lineBreak)".data(
                using: .utf8)!
        )
        body.append("Content-Type: \(mimeType)\(lineBreak)\(lineBreak)".data(using: .utf8)!)
        body.append(data)
        body.append("\(lineBreak)--\(boundary)--\(lineBreak)".data(using: .utf8)!)
        return body
    }

    private func performUpload(
        with request: URLRequest,
        bodyData: Data,
        progressHandler: (@Sendable (Double) -> Void)?
    ) async throws -> (Data, HTTPURLResponse) {
        logRequest(request)
        let delegate: URLSessionTaskDelegate? = progressHandler.map { ProgressDelegate(handler: $0) }

        do {
            let (data, response) = try await transport.upload(
                for: request,
                from: bodyData,
                delegate: delegate
            )
            logResponse(response, data: data)

            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("Invalid response type")
                throw NetworkError.invalidResponse
            }

            critical.withLock { $0.lastResponse = httpResponse }

            let message = responseHandler.decodeServerMessage(from: data)
            try authenticator.validate(response: httpResponse, message: message)
            _ = try responseHandler.validate(response: httpResponse, data: data)

            return (data, httpResponse)
        } catch let error as NetworkError {
            throw error
        } catch let error as URLError {
            if error.code == .cancelled {
                logger.debug("Request cancelled")
                throw NetworkError.cancelled
            }
            logger.error("Network error: \(error.localizedDescription)")
            throw NetworkError.networkError(error)
        } catch {
            logger.error("Network error: \(error.localizedDescription)")
            throw NetworkError.networkError(error)
        }
    }
}

private final class ProgressDelegate: NSObject, URLSessionTaskDelegate {
    private let handler: @Sendable (Double) -> Void

    init(handler: @escaping @Sendable (Double) -> Void) {
        self.handler = handler
    }

    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64
    ) {
        guard totalBytesExpectedToSend > 0 else { return }
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        handler(progress)
    }
}

private final class RedirectDisablingDelegate: NSObject, URLSessionTaskDelegate {
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest
    ) async -> URLRequest? {
        // Return nil to suppress automatic redirection so callers can handle 3xx manually.
        return nil
    }
}

private extension URLRequest {
    var allHTTPHeaderFieldsSafe: [String: String]? {
        allHTTPHeaderFields?.reduce(into: [String: String]()) {
            result, header in
            if header.key.lowercased() == "authorization" {
                result[header.key] = "Bearer [REDACTED]"
            } else {
                result[header.key] = header.value
            }
        }
    }
}
