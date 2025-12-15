import Foundation
import OSLog

public protocol NetworkAuthenticating: AnyObject {
    var token: OauthToken? { get set }
    var hasToken: Bool { get }

    func applyAuthentication(to request: inout URLRequest)
    func validate(response: HTTPURLResponse, message: String?) throws
}

public final class DefaultAuthenticator: NetworkAuthenticating {
    private let logger = NetworkLogger.core
    private let lock = OSAllocatedUnfairLock<OauthToken?>(initialState: nil)

    public init(token: OauthToken? = nil) {
        self.token = token
    }

    public var token: OauthToken? {
        get { lock.withLock { $0 } }
        set { lock.withLock { $0 = newValue } }
    }

    public var hasToken: Bool {
        lock.withLock { $0 != nil }
    }

    public func applyAuthentication(to request: inout URLRequest) {
        guard let token = lock.withLock({ $0?.accessToken }) else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }

    public func validate(response: HTTPURLResponse, message: String?) throws {
        switch response.statusCode {
        case 401:
            logger.error("Unauthorized request")
            throw NetworkError.reauthenticationRequired(message: message)
        case 403:
            logger.error("Forbidden request")
            if hasToken {
                throw NetworkError.reauthenticationRequired(message: message)
            } else {
                throw NetworkError.authenticationRequired(message: message)
            }
        default:
            break
        }
    }
}
