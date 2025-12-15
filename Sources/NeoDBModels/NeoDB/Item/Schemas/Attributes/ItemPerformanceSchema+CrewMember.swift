//
//  CrewMemberSchema.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import Foundation

extension ItemPerformanceSchema {
    public struct CrewMember: Codable, Equatable, Hashable, Sendable {
        public let name: String
        public let role: String?
    }
}
