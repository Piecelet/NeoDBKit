//
//  ExternalResourceSchema.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import Foundation
import SymbolKit

public struct ItemExternalResourceSchema: Codable, Hashable, Equatable, Sendable, Identifiable {
    public let url: URL
    
    public var id: String {
        url.absoluteString
    }
}
