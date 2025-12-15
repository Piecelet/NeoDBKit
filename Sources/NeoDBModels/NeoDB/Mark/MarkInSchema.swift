//
//  MarkIn.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/3/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public struct MarkInSchema: MarkProtocol {
    public var shelfType: ShelfType
    public var visibility: NeoDBVisibility
    public var commentText: String = ""
    public var ratingGrade: Int = 0
    public var tags: [String] = []
    public var createdTime: ServerDate? = nil
    public var postToFediverse: NeoDBPostToFediverse? = nil
    public let postId: String?
    public let item: ItemSchema?
    
    public var id: String { UUID().uuidString } // 临时 ID，因为这是输入数据
    
    public init(
        shelfType: ShelfType,
        visibility: NeoDBVisibility,
        commentText: String = "",
        ratingGrade: Int = 0,
        tags: [String],
        createdTime: ServerDate?,
        postToFediverse: Bool?,
    ) {
        self.shelfType = shelfType
        self.visibility = visibility
        self.commentText = commentText
        self.ratingGrade = ratingGrade
        self.tags = tags
        self.createdTime = createdTime
        self.postToFediverse = postToFediverse
        self.postId = nil
        self.item = nil
    }
}

extension MarkInSchema {
    public func toMarkSchema(item: ItemSchema) -> MarkSchema {
        MarkSchema(
            shelfType: shelfType,
            visibility: visibility,
            postId: UUID().uuidString,
            item: item,
            createdTime: createdTime,
            commentText: commentText,
            ratingGrade: ratingGrade,
            tags: tags
        )
    }
}
