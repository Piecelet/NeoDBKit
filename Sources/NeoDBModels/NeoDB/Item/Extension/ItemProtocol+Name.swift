//
//  ItemProtocol+Name.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/6/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension ItemProtocol {
    public func localizedDisplayTitle(language: ItemLocalizedText.KnownLanguage) -> String {
        if let localizedTitle = self.localizedTitle?.textForLanguage(language), !localizedTitle.isEmpty {
            return localizedTitle
        }
        return (self.displayTitle ?? self.title ?? self.uuid).trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var localizedDisplayTitle: String {
        if let localizedTitle = self.localizedTitle?.textForCurrentLocale, !localizedTitle.isEmpty {
            return localizedTitle
        }
        return (self.displayTitle ?? self.title ?? self.uuid).trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var localizedDisplayTitleWithYear: String {
        var title = self.localizedDisplayTitle
        if let movie = self as? MovieSchema, let year = movie.year {
            title += " (\(year))"
        }
        return title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var localizedDisplayDescription: String? {
        if let localizedDescription = self.localizedDescription?.textForCurrentLocale, !localizedDescription.isEmpty {
            return localizedDescription
        }
        return self.description?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var originalDisplayTitleIfAvailable: String? {
        var originalTitle: String?
        switch self {
        case let book as EditionSchema:
            originalTitle = book.origTitle
        case let movie as MovieSchema:
            originalTitle = movie.origTitle
        case let tv as TVShowSchema:
            originalTitle = tv.origTitle
        case let performance as PerformanceSchema:
            originalTitle = performance.origTitle
        default:
            break
        }
        originalTitle = originalTitle?.trimmingCharacters(in: .whitespacesAndNewlines)
        if originalTitle == String(self.localizedDisplayTitle) {
            return nil
        } else {
            return originalTitle
        }
    }

    public var originalDisplayTitleWithYearIfAvailable: String? {
        guard let originalTitle = self.originalDisplayTitleIfAvailable else {
            return nil
        }
        var title = originalTitle
        switch self {
        case let movie as MovieSchema:
            if let year = movie.year {
                title += " (\(year))"
            }
        default:
            break
        }
        return title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public func originalDisplayTitleWithYearIfAvailableWithoutDuplicate(_ displayTitle: String) -> String? {
        guard let originalTitle = self.originalDisplayTitleIfAvailable else {
            return nil
        }
        var title = originalTitle
        if title == displayTitle {
            title = ""
        }
        switch self {
        case let movie as MovieSchema:
            if let year = movie.year {
                title += " (\(year))"
            }
        default:
            break
        }
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return nil
        }
        return title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var displayYearIfAvailable: String? {
        switch self {
        case let movie as MovieSchema:
            if let year = movie.year {
                return "\(year)"
            }
        default:
            break
        }
        return nil
    }
}
