import Foundation
import OSLog
import NeoDBModels

public struct ResponseHandler {
    private let logger = NetworkLogger.core
    public let decoder: JSONDecoder

    public init(decoder: JSONDecoder = Self.makeDefaultDecoder()) {
        self.decoder = decoder
    }

    public func validate(response: HTTPURLResponse, data: Data) throws -> String? {
        let message = decodeServerMessage(from: data)
        guard (200...299).contains(response.statusCode) else {
            logger.error("HTTP error: \(response.statusCode)")
            throw NetworkError.httpError(code: response.statusCode, message: message)
        }
        return message
    }

    public func decode<T: Decodable>(
        _ type: T.Type,
        from data: Data,
        endpoint: NetworkEndpoint
    ) throws -> T {
        if T.self == HTMLPage.self {
            guard let htmlString = String(data: data, encoding: .utf8) else {
                logger.error("Failed to decode HTML string from data")
                throw NetworkError.decodingError(NSError(domain: "", code: -1))
            }
            return HTMLPage(stringValue: htmlString) as! T
        }

        do {
            return try decoder.decode(type, from: data)
        } catch {
            logDecodingError(error, endpoint: endpoint, data: data, type: type)
            if let message = decodeServerMessage(from: data) {
                logger.error("Received error message from server: \(message)")
                throw NetworkError.messageError(message)
            }
            throw NetworkError.decodingError(error)
        }
    }

    public func decodeServerMessage(from data: Data) -> String? {
        guard !data.isEmpty else { return nil }
        return try? decoder.decode(NeoDBMessage.self, from: data).message
    }

    private func logDecodingError<T>(
        _ error: Error,
        endpoint: NetworkEndpoint,
        data: Data,
        type: T.Type
    ) {
        logger.error("""
            Decoding error for \(String(describing: type))
            Endpoint: \(endpoint.path)
            Error: \(error.localizedDescription)
            Raw Data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")
            Debug Description: \(error)
            """)

        if let decodingError = error as? DecodingError {
            switch decodingError {
            case .keyNotFound(let key, let context):
                logger.error("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                logger.error("Coding path: \(context.codingPath.map { $0.stringValue })")
            case .valueNotFound(let type, let context):
                logger.error("Value of type '\(type)' not found: \(context.debugDescription)")
                logger.error("Coding path: \(context.codingPath.map { $0.stringValue })")
            case .typeMismatch(let type, let context):
                logger.error("Type '\(type)' mismatch: \(context.debugDescription)")
                logger.error("Coding path: \(context.codingPath.map { $0.stringValue })")
            case .dataCorrupted(let context):
                logger.error("Data corrupted: \(context.debugDescription)")
                logger.error("Coding path: \(context.codingPath.map { $0.stringValue })")
            @unknown default:
                logger.error("Unknown decoding error: \(decodingError)")
            }
        }
    }

    public static func makeDefaultDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
