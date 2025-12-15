//
//  ItemKnownExternalResource+AppSchema.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/3/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public extension ItemExternalResourceSchema {
#if canImport(UIKit)
    func canOpenURL() -> Bool {
        if let scheme = self.type.scheme {
            return UIApplication.shared.canOpenURL(URL(string: scheme)!)
        }
        return false
    }
#endif

    func makeAppScheme() -> URL? {
        switch self.type {
        case .douban:
            let host = url.host ?? ""
            let type = host.replacingOccurrences(of: ".douban.com", with: "")
            let id = url.pathComponents.last ?? ""
            let scheme = URL(string: "\(self.type.scheme ?? "douban://")douban.com/\(type)/\(id)")
            if host.isEmpty || type.isEmpty || id.isEmpty || !canOpenURL() {
                return nil
            }
            return scheme
        case .goodreads:
            let path = url.pathComponents.filter { $0 != "/" }.joined(separator: "/")
            let scheme = URL(string: "\(self.type.scheme ?? "goodreads://")\(path)")
            if path.isEmpty || !canOpenURL() {
                return nil
            }
            return scheme
        case .booksTW:
            return nil
        case .googleBooks:
            return nil
        case .imdb:
            let id: String = url.pathComponents.last ?? ""
            let scheme = URL(string: "\(self.type.scheme ?? "imdb:///")\(id)")
            if id.isEmpty || !canOpenURL() {
                return nil
            }
            return scheme
        case .tmdb:
            return nil
        case .bangumi:
            let path: String = url.pathComponents.filter { $0 != "/" }.joined(separator: "/")
            let scheme = URL(string: "\(self.type.scheme ?? "bangumi://")\(path)")
            if path.isEmpty || !canOpenURL() {
                return nil
            }
            return scheme
        case .bandcamp:
            // TODO: Need to fetch webpage
            // ref https://hisaac.net/blog/deep-linking-in-the-bandcamp-ios-app/
            return nil
        case .spotify:
            let path: String = url.pathComponents.filter { $0 != "/" }.joined(separator: ":")
            let scheme = URL(string: "\(self.type.scheme ?? "spotify:")\(path)")
            if path.isEmpty || !canOpenURL() {
                return nil
            }
            return scheme
        case .appleMusic:
            if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                components.scheme = "music"
                if let musicURL = components.url, canOpenURL() {
                    return musicURL
                }
            }
            return nil
        case .discogs:
            return nil
        case .applePodcasts:
            if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                components.scheme = "podcasts"
                if let podcastsURL = components.url, canOpenURL() {
                    return podcastsURL
                }
            }
            return nil
        case .igdb:
            return nil
        case .steam:
            return nil
        default: return nil
        }
    }
}

extension ItemExternalResourceSchema {
    public func makeAppSearchScheme(query: String) -> URL? {
        if !canOpenURL() {
            return nil
        }
        switch self.type {
        case .douban:
            return URL(string: "\(self.type.scheme ?? "douban://")/search?q=\(query)")
        default: return nil
        }
    }
}
