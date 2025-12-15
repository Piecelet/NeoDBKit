//
//  ItemCategory+Gallery.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/13/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension ItemCategory {
   public enum galleryCategory: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
       case book
       case movie
       case tv
       case music
       case game
       case podcast
       case collection

       public var itemCategory: ItemCategory {
           switch self {
           case .book: return .book
           case .movie: return .movie
           case .tv: return .tv
           case .music: return .music
           case .game: return .game
           case .podcast: return .podcast
           case .collection: return .collection
           }
       }

       public var displayName: String {
           itemCategory.displayNamePluralAbbreviated
       }

       public static let availableCategories: [galleryCategory] = [.book, .movie, .tv, .music, .game, .podcast]
   }
}

