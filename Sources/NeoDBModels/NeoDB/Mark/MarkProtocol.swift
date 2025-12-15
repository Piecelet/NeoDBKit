//
//  MarkProtocol.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/3/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public protocol MarkProtocol: Codable, Identifiable, Equatable, Hashable, Sendable {
    var shelfType: ShelfType { get }
    var visibility: NeoDBVisibility { get }
    // var postId: String? { get }
    // var item: ItemSchema? { get }
    var createdTime: ServerDate? { get }
    var commentText: String { get }
    var tags: [String] { get }
    var ratingGrade: Int { get }
    // var postToFediverse: NeoDBPostToFediverse? { get }
}
