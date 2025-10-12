//
//  LocalizedTitleSchema.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import Foundation

public struct LocalizedTitleSchema: Codable, Sendable {
    public let lang: String
    public let text: String
}
