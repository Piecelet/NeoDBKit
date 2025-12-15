//
//  MarkSchema.swift
//  NeoDBKit
//
//  Created by citron on 1/15/25.
//

import Foundation

public struct MarkSchema: MarkProtocol {
    public let shelfType: ShelfType
    public let visibility: NeoDBVisibility
    public let postId: String
    public let item: ItemSchema
    public let createdTime: ServerDate?
    public let commentText: String
    public let ratingGrade: Int
    public let tags: [String]
    
    public var id: String {
        let components = [
            postId,
            "i\(item.id)",
            "t\(shelfType.rawValue)",
            createdTime.map { "c\($0)" }
        ].compactMap { $0 }
        
        return components.joined(separator: "_")
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        shelfType = try container.decode(ShelfType.self, forKey: .shelfType)
        visibility = try container.decode(NeoDBVisibility.self, forKey: .visibility)
        do {
            postId = try container.decode(String.self, forKey: .postId)
        } catch DecodingError.typeMismatch {
            postId = try String(container.decode(Int.self, forKey: .postId))
        }
        item = (try? container.decode(ItemSchema.self, forKey: .item)) ?? ItemSchema.placeholder
        createdTime = (try? container.decode(ServerDate.self, forKey: .createdTime)) ?? nil
        commentText = (try? container.decode(String.self, forKey: .commentText)) ?? ""
        ratingGrade = (try? container.decode(Int.self, forKey: .ratingGrade)) ?? 0
        tags = (try? container.decode([String].self, forKey: .tags)) ?? []
    }

    public init(
        shelfType: ShelfType,
        visibility: NeoDBVisibility,
        postId: String,
        item: ItemSchema,
        createdTime: ServerDate?,
        commentText: String,
        ratingGrade: Int,
        tags: [String]
    ) {
        self.shelfType = shelfType
        self.visibility = visibility
        self.postId = postId
        self.item = item
        self.createdTime = createdTime
        self.commentText = commentText
        self.ratingGrade = ratingGrade
        self.tags = tags
    }
}

extension MarkSchema {
    public static var placeholder: MarkSchema {
        .init(
            shelfType: .wishlist,
            visibility: .pub,
            postId: UUID().uuidString,
            item: .placeholder,
            createdTime: ServerDate(),
            commentText: "",
            ratingGrade: 0,
            tags: []
        )
    }
}
