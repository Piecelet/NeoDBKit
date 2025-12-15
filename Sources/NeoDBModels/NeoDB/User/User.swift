//
//  User.swift
//  NeoDB
//
//  Created by citron(https://github.com/lcandy2) on 1/7/25.
//

import Foundation

public struct User: Codable, Identifiable {
    public let url: URL
    public let externalAcct: String?
    public let externalAccounts: [ExternalAccount]
    public let displayName: String
    public let avatar: URL
    public let username: String
    public let roles: [UserRoles]

    public init(
        url: URL,
        externalAcct: String? = nil,
        externalAccounts: [ExternalAccount] = [],
        displayName: String,
        avatar: URL,
        username: String,
        roles: [UserRoles]
    ) {
        self.url = url
        self.externalAcct = externalAcct
        self.externalAccounts = externalAccounts
        self.displayName = displayName
        self.avatar = avatar
        self.username = username
        self.roles = roles
    }

    public var id: URL {
        return url
    }
}

public struct ExternalAccount: Codable, Hashable, Identifiable {
    public let platform, handle: String
    public let url: String?
    
    public var id: String {
        return url ?? "\(platform)-\(handle)"
    }
}

public enum UserRoles: String, Codable {
    case admin
    case staff
}


extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.url == rhs.url
    }
    
    public static func placeholder() -> User {
        return User(
            url: URL(string: "https://placehold.co/100x100")!,
            externalAcct: nil,
            externalAccounts: [],
            displayName: String(localized: "account_displayname", table: "Settings", comment: "A placeholder of the display name of an account."),
            avatar: URL(string: "https://placehold.co/100x100")!,
            username: "@username",
            roles: [])
    }
}

public struct UserUnauthorized: Codable {
    public let detail: String

    public enum CodingKeys: String, CodingKey {
        case detail
    }
}
