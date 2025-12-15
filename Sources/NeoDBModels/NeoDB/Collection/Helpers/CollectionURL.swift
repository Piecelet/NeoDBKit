//
//  CollectionURL.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 12/6/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

extension Foundation.URL {
    /// Checks if the URL is a valid NeoDB collection link.
    /// - Returns: `true` if the URL matches the NeoDB collection pattern, otherwise `false`.
    public var isCollectionLink: Bool {
        // Example pattern: https://neodb.social/collection/{collectionID}
        let pathComponents = self.pathComponents
        guard pathComponents.count >= 3 else {
            return false
        }
        return pathComponents[1] == "collection" && !pathComponents[2].isEmpty
    }
    
    public var collectionUUID: CollectionAttributes.UUID? {
        guard isCollectionLink else {
            return nil
        }
        let pathComponents = self.pathComponents
        return pathComponents[2]
    }
}
