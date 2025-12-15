//
//  StatusExtNeoDB.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/5/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public struct MastodonStatusExperimentUseOnlyExtNeoDB: Codable, Sendable, Hashable, Equatable {
    public let isEdited: Bool?
    public let tags: [ExperimentUseOnlyTag]
    public let relatedWith: [ExperimentUseOnlyRelatedWith]

    private enum CodingKeys: String, CodingKey {
        case isEdited
        case tags = "tag"
        case relatedWith
    }

    public init(
        isEdited: Bool? = nil,
        tags: [ExperimentUseOnlyTag] = [],
        relatedWith: [ExperimentUseOnlyRelatedWith] = []
    ) {
        self.isEdited = isEdited
        self.tags = tags
        self.relatedWith = relatedWith
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEdited = try container.decodeIfPresent(Bool.self, forKey: .isEdited)
        tags = try container.decodeIfPresent([ExperimentUseOnlyTag].self, forKey: .tags) ?? []
        relatedWith = try container.decodeIfPresent([ExperimentUseOnlyRelatedWith].self, forKey: .relatedWith) ?? []
    }
}

public extension MastodonStatusExperimentUseOnlyExtNeoDB {
    struct ExperimentUseOnlyTag: Codable, Sendable, Hashable, Equatable {
        public let href: String?
        public let name: String?
        public let type: String?
        public let image: String?

        public init(
            href: String? = nil,
            name: String? = nil,
            type: String? = nil,
            image: String? = nil
        ) {
            self.href = href
            self.name = name
            self.type = type
            self.image = image
        }
    }

    struct ExperimentUseOnlyRelatedWith: Codable, Sendable, Identifiable, Hashable, Equatable {
        public let id: String
        public let href: String?
        public let type: String?
        public let status: String?
        public let content: String?
        public let updated: ServerDate?
        public let published: ServerDate?
        public let attributedTo: String?
        public let withRegardTo: String?
        public let best: Int?
        public let worst: Int?
        public let value: Int?

        private enum CodingKeys: String, CodingKey {
            case id
            case href
            case type
            case status
            case content
            case updated
            case published
            case attributedTo
            case withRegardTo
            case best
            case worst
            case value
        }

        public init(
            id: String,
            href: String? = nil,
            type: String? = nil,
            status: String? = nil,
            content: String? = nil,
            updated: ServerDate? = nil,
            published: ServerDate? = nil,
            attributedTo: String? = nil,
            withRegardTo: String? = nil,
            best: Int? = nil,
            worst: Int? = nil,
            value: Int? = nil
        ) {
            self.id = id
            self.href = href
            self.type = type
            self.status = status
            self.content = content
            self.updated = updated
            self.published = published
            self.attributedTo = attributedTo
            self.withRegardTo = withRegardTo
            self.best = best
            self.worst = worst
            self.value = value
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let decodedId = try container.decodeIfPresent(String.self, forKey: .id) {
                id = decodedId
            } else if let fallbackId = try container.decodeIfPresent(String.self, forKey: .href) {
                id = fallbackId
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: .id,
                    in: container,
                    debugDescription: "RelatedWith requires an id or href value"
                )
            }
            href = try container.decodeIfPresent(String.self, forKey: .href)
            type = try container.decodeIfPresent(String.self, forKey: .type)
            status = try container.decodeIfPresent(String.self, forKey: .status)
            content = try container.decodeIfPresent(String.self, forKey: .content)
            updated = try container.decodeIfPresent(ServerDate.self, forKey: .updated)
            published = try container.decodeIfPresent(ServerDate.self, forKey: .published)
            attributedTo = try container.decodeIfPresent(String.self, forKey: .attributedTo)
            withRegardTo = try container.decodeIfPresent(String.self, forKey: .withRegardTo)
            best = Self.decodeIntOrString(container: container, forKey: .best)
            worst = Self.decodeIntOrString(container: container, forKey: .worst)
            value = Self.decodeIntOrString(container: container, forKey: .value)
        }

        private static func decodeIntOrString(
            container: KeyedDecodingContainer<CodingKeys>,
            forKey key: CodingKeys
        ) -> Int? {
            if let intValue = try? container.decodeIfPresent(Int.self, forKey: key) {
                return intValue
            }
            if let stringValue = try? container.decodeIfPresent(String.self, forKey: key) {
                return Int(stringValue)
            }
            return nil
        }
    }
}
