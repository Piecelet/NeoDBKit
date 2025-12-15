import Foundation

public enum UserEndpoint {
    case me
    case token
    case myPreferences
    case user(handle: String)
}

extension UserEndpoint: NetworkEndpoint {
    public var path: String {
        switch self {
        case .me:
            return "/me"
        case .token:
            return "/oauth/token"
        case .myPreferences:
            return "/me/preference"
        case .user(let handle):
            let encodedHandle = handle.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? handle
            return "/user/\(encodedHandle)"
        }
    }
}
