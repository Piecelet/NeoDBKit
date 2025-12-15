//
//  ShelfType+Symbol.swift
//  NeoDB
//
//  Created by OpenAI Assistant on 2025/09/xx.
//

import Foundation
import SymbolKit

extension ShelfType {
    public var symbolImage: Symbol {
        switch self {
        case .wishlist: return .systemSymbol("heart")
        case .progress: return .systemSymbol("circle.circle")
        case .complete: return .systemSymbol("checkmark.circle")
        case .dropped: return .systemSymbol("xmark.bin.circle")
        }
    }

    public var symbolImageFill: Symbol {
        switch self {
        case .wishlist: return .systemSymbol("heart.fill")
        case .progress: return .systemSymbol("circle.circle.fill")
        case .complete: return .systemSymbol("checkmark.circle.fill")
        case .dropped: return .systemSymbol("xmark.bin.circle.fill")
        }
    }

    public var symbolActionStateAdd: Symbol {
        switch self {
        case .wishlist: return .custom("custom.heart.badge.plus")
        case .progress: return .custom("custom.circle.circle.badge.plus")
        case .complete: return .custom("checkmark.circle.badge.plus")
        case .dropped: return symbolImage
        }
    }

    public var symbolActionStateRemove: Symbol {
        switch self {
        case .wishlist: return .custom("custom.heart.badge.minus")
        case .progress: return .custom("custom.circle.circle.badge.minus")
        case .complete: return .custom("custom.star.badge.minus")
        case .dropped: return symbolImage
        }
    }

    public var symbolActionStateDone: Symbol {
        switch self {
        case .wishlist: return .custom("custom.heart.badge.checkmark.badge.plus")
        case .progress: return .custom("custom.circle.circle.badge.checkmark")
        case .complete: return symbolImage
        case .dropped: return symbolImage
        }
    }

    public var symbolActionStateUndone: Symbol {
        switch self {
        case .wishlist: return .custom("custom.heart.badge.xmark")
        case .progress: return .custom("custom.circle.circle.badge.xmark")
        case .complete: return .custom("checkmark.circle.badge.xmark")
        case .dropped: return symbolImage
        }
    }

    public var symbolActionStateAddFill: Symbol {
        switch self {
        case .wishlist: return .custom("custom.heart.fill.badge.plus")
        case .progress: return .custom("custom.circle.circle.fill.badge.plus")
        case .complete: return .custom("checkmark.circle.badge.plus.fill")
        case .dropped: return symbolImageFill
        }
    }

    public var symbolActionStateRemoveFill: Symbol {
        switch self {
        case .wishlist: return .custom("custom.heart.fill.badge.minus")
        case .progress: return .custom("custom.circle.circle.fill.badge.minus")
        case .complete: return .custom("custom.star.fill.badge.minus")
        case .dropped: return symbolImageFill
        }
    }

    public var symbolActionStateDoneFill: Symbol {
        switch self {
        case .wishlist: return .custom("custom.heart.fill.badge.checkmark")
        case .progress: return .custom("custom.circle.circle.fill.badge.checkmark")
        case .complete: return symbolImageFill
        case .dropped: return symbolImageFill
        }
    }

    public var symbolActionStateUndoneFill: Symbol {
        switch self {
        case .wishlist: return .custom("custom.heart.fill.badge.xmark")
        case .progress: return .custom("custom.circle.circle.fill.badge.xmark")
        case .complete: return .custom("checkmark.circle.trianglebadge.exclamationmark.fill")
        case .dropped: return symbolImageFill
        }
    }
}
