//
//  Placeholders.swift
//  NeoDB
//
//  Central list of URL indicators that represent placeholder images.
//

import Foundation

public enum Placeholders {
    // Substring indicators inside URL absoluteString that denote placeholders
    public static let urlIndicators: [String] = [
        "neodb.internal/placeholder",
        "neodb.internal/users",
        "piecelet.internal/placeholder", 
        "/img/fjords-banner-600.fa337a5055b6.jpg", // https://neodb.social/static/img/fjords-banner-600.fa337a5055b6.jpg
        "/img/missing.5fa23ea9f65e.png", // https://neodb.social/static/img/missing.5fa23ea9f65e.png
        "/m/item/default.svg", // https://neodb.social/m/item/default.svg
        "/s/img/avatar.svg", // https://neodb.social/s/img/avatar.svg
        "/s/img/missing.png" // https://neodb.social/s/img/missing.png
    ]

    public static func isPlaceholderURL(_ url: URL?) -> Bool {
        guard let s = url?.absoluteString else { return false }
        return urlIndicators.contains { s.contains($0) }
    }
    
    public static func isPlaceholderURL(_ urlString: String?) -> Bool {
        guard let s = urlString else { return false }
        return urlIndicators.contains { s.contains($0) }
    }
}

