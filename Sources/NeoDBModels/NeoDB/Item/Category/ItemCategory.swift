//
//  ItemCategory.swift
//  NeoDB
//
//  Created by citron on 1/15/25.
//

import SwiftUI

public enum ItemCategory: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
    case book
    case movie
    case tv
    // @available(*, deprecated, message: "tvSeason is now handled by ItemType as NeoDB did this change.")
    // case tvSeason
    // @available(*, deprecated, message: "tvEpisode is now handled by ItemType as NeoDB did this change.")
    // case tvEpisode
    case music
    case game
    case podcast
    // @available(*, deprecated, message: "podcastEpisode is now handled by ItemType as NeoDB did this change.")
    // case podcastEpisode = "podcastepisode"
    case performance
    // @available(*, deprecated, message: "performanceProduction is now handled by ItemType as NeoDB did this change.")
    // case performanceProduction
    // @available(*, deprecated, message: "fanfic is now handled by ItemType as NeoDB did this change.")
    // case fanfic
    // @available(*, deprecated, message: "exhibition is now handled by ItemType as NeoDB did this change.")
    // case exhibition
    case collection
}

extension ItemCategory {
    public var urlPath: String {
        self.rawValue
    }
}

extension ItemCategory {
    public var type: ItemType {
        switch self {
        case .book: return .book
        case .movie: return .movie
        case .tv: return .tv
        case .music: return .music
        case .podcast: return .podcast
        case .game: return .game
        case .performance: return .performance
        default: return .unknown
        }
    }
}

extension ItemCategory {

//    var symbolImage: Symbol {
//        switch self {
//        case .book: return .sfSymbol(.book)
//        case .movie: return .sfSymbol(.film)
//        case .tv: return .sfSymbol(.tv)
//        case .tvSeason: return .sfSymbol(.tv)
//        case .tvEpisode: return .sfSymbol(.tv)
//        case .music: return .sfSymbol(.musicNote)
//        case .game: return .systemSymbol("gamecontroller")
//        case .podcast, .podcastEpisode: return .custom("custom.podcast")
//        case .performance: return .sfSymbol(.theatermasks)
//        case .performanceProduction: return .sfSymbol(.theatermasks)
//        case .fanfic: return .sfSymbol(.book)
//        case .exhibition: return .sfSymbol(.theatermasks)
//        case .collection: return .sfSymbol(.squareGrid2x2)
//        }
//    }

//    var symbolImageFill: Symbol {
//        switch self {
//        case .book: return .sfSymbol(.bookFill)
//        case .movie: return .sfSymbol(.filmFill)
//        case .tv, .tvSeason, .tvEpisode: return .sfSymbol(.tvFill)
//        case .music: return .sfSymbol(.musicNote)
//        case .game: return .systemSymbol("gamecontroller.fill")
//        case .podcast, .podcastEpisode: return .custom("custom.podcast")
//        case .performance, .performanceProduction: return .sfSymbol(.theatermasksFill)
//        case .fanfic: return .sfSymbol(.bookFill)
//        case .exhibition: return .sfSymbol(.theatermasksFill)
//        case .collection: return .sfSymbol(.squareGrid2x2Fill)
//        }
//    }
//
//    var color: Color {
//        switch self {
//        case .book: 
//            return Color(red: 236/255, green: 138/255, blue: 37/255)  // 柔和橙色
//        case .movie:
//            return Color(red: 226/255, green: 62/255, blue: 87/255)   // 柔和紅色
//        case .tv, .tvSeason, .tvEpisode: 
//            return Color(red: 77/255, green: 75/255, blue: 186/255)   // 靛藍紫色
//        case .music:
//            return Color(red: 211/255, green: 82/255, blue: 73/255)   // 柔和紅色
//        case .game: 
//            return Color(red: 215/255, green: 153/255, blue: 33/255)  // 深金黃色
//        case .podcast, .podcastEpisode: 
//            return Color(red: 156/255, green: 85/255, blue: 191/255)  // 紫色
//        case .performance, .performanceProduction: 
//            return Color(red: 86/255, green: 112/255, blue: 154/255)  // 深藍色
//        case .fanfic: 
//            return Color(red: 98/255, green: 122/255, blue: 180/255)  // 柔和藍色
//        case .exhibition: 
//            return Color(red: 128/255, green: 128/255, blue: 128/255) // 中性灰
//        case .collection: 
//            return Color(red: 128/255, green: 128/255, blue: 128/255) // 中性灰
//        }
//    }
//
//    var uiColor: UIColor {
//        return UIColor(color)
//    }
//
   public var displayNamePlural: String {
       switch self {
       case .book: return String(localized: "neodb.item.category.book.label.plural", defaultValue: "Books", bundle: .module, comment: "Plural noun without action, usually referring to a collection of books")
       case .movie: return String(localized: "neodb.item.category.movie.label.plural", defaultValue: "Movies", bundle: .module, comment: "Plural noun without action, usually referring to a collection of movies")
       case .tv: return String(localized: "neodb.item.category.tv.label.plural", defaultValue: "TV Shows", bundle: .module, comment: "Plural noun without action, usually referring to a collection of tv shows")
       case .music: return String(localized: "neodb.item.category.music.label.plural", defaultValue: "Music", bundle: .module, comment: "Plural noun without action, usually referring to a collection of music")
       case .game: return String(localized: "neodb.item.category.game.label.plural", defaultValue: "Games", bundle: .module, comment: "Plural noun without action, usually referring to a collection of games")
       case .podcast: return String(localized: "neodb.item.category.podcast.label.plural", defaultValue: "Podcasts", bundle: .module, comment: "Plural noun without action, usually referring to a collection of podcasts")
       case .performance: return String(localized: "neodb.item.category.performance.label.plural", defaultValue: "Performances", bundle: .module, comment: "Plural noun without action, usually referring to a collection of performances")
       // case .fanfic: return String(localized: "neodb.item.category.fanfic.label.plural", defaultValue: "Fanfics", bundle: .module, comment: "Plural noun without action, usually referring to a collection of fanfics")
       // case .exhibition: return String(localized: "neodb.item.category.exhibition.label.plural", defaultValue: "Exhibitions", bundle: .module, comment: "Plural noun without action, usually referring to a collection of exhibitions")
       case .collection: return String(localized: "neodb.item.category.collection.label.plural", defaultValue: "Collections", bundle: .module, comment: "Plural noun without action, usually referring to a collection of collections")
       }
   }

   public var displayNameSingular: String {
       switch self {
       case .book: return String(localized: "neodb.item.category.book.label.singular", defaultValue: "Book", bundle: .module, comment: "Singular noun without action, usually referring to a single book")
       case .movie: return String(localized: "neodb.item.category.movie.label.singular", defaultValue: "Movie", bundle: .module, comment: "Singular noun without action, usually referring to a single movie")
       case .tv: return String(localized: "neodb.item.category.tv.label.singular", defaultValue: "TV Show", bundle: .module, comment: "Singular noun without action, usually referring to a single tv show")
       case .music: return String(localized: "neodb.item.category.music.label.singular", defaultValue: "Music", bundle: .module, comment: "Singular noun without action, usually referring to a single music")
       case .game: return String(localized: "neodb.item.category.game.label.singular", defaultValue: "Game", bundle: .module, comment: "Singular noun without action, usually referring to a single game")
       case .podcast: return String(localized: "neodb.item.category.podcast.label.singular", defaultValue: "Podcast", bundle: .module, comment: "Singular noun without action, usually referring to a single podcast")
       case .performance: return String(localized: "neodb.item.category.performance.label.singular", defaultValue: "Performance", bundle: .module, comment: "Singular noun without action, usually referring to a single performance")
       // case .fanfic: return String(localized: "neodb.item.category.fanfic.label.singular", defaultValue: "Fanfic", bundle: .module, comment: "Singular noun without action, usually referring to a single fanfic")
       // case .exhibition: return String(localized: "neodb.item.category.exhibition.label.singular", defaultValue: "Exhibition", bundle: .module, comment: "Singular noun without action, usually referring to a single exhibition")
       case .collection: return String(localized: "neodb.item.category.collection.label.singular", defaultValue: "Collection", bundle: .module, comment: "Singular noun without action, usually referring to a single collection")
       }
   }

   @available(*, deprecated, message: "Use displayNamePlural or displayNameSingular instead.")
   public var displayName: String {
       return self.displayNamePlural
   }

   public var displayNamePluralAbbreviated: String {
       switch self {
       case .tv: return String(localized: "neodb.item.category.tv.label.plural.abbreviated", defaultValue: "TV", bundle: .module, comment: "Abbreviated plural noun without action, usually referring to a collection of tv shows")
       default: return self.displayNamePlural
       }
   }

   public var displayNameSingularAbbreviated: String {
       switch self {
       case .tv: return String(localized: "neodb.item.category.tv.label.singular.abbreviated", defaultValue: "TV", bundle: .module, comment: "Abbreviated singular noun without action, usually referring to a single tv show")
       default: return self.displayNameSingular
       }
   }

   @available(*, deprecated, message: "Use displayNamePluralAbbreviated or displayNameSingularAbbreviated instead.")
   public var displayNameAbbreviated: String {
       return self.displayNamePluralAbbreviated
   }

//    var placeholderRatio: CGFloat {
//        switch self {
//        case .music, .podcast, .podcastEpisode: return 1/1
//        default: return 3/4
//        }
//    }
//    
//    var ratio: CGFloat? {
//        switch self {
//        case .book, .tv, .tvSeason, .tvEpisode, .movie: return 3/4
//        default: return nil
//        }
//    }
}