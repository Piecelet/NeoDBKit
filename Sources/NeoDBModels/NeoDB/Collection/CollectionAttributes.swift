//
//  CollectionAttributes.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation

public enum CollectionAttributes {
    /// Unique identifier of a collection.
    /// Example: "5AztxcMQWFsjyS1Klt0E6L"
    public typealias UUID = String

    /// Relative web URL to view a collection.
    /// Example: "/collection/5AztxcMQWFsjyS1Klt0E6L"
    public typealias URL = String

    /// Relative API URL for a collection.
    /// Example: "/api/collection/5AztxcMQWFsjyS1Klt0E6L"
    /// Note: Some NeoDB versions may include a double slash ("/api//collection/…").
    public typealias ApiURL = String

    /// Absolute URL of a collection's cover image.
    /// Example: "https://neodb.social/m/collection/2022/09/07fdf59c13-8719-40a5-9d04-2852119db3e7.jpg"
    public typealias CoverImageURL = Foundation.URL

    /// Relative URL of a collection's cover image.
    /// Deprecated. Use `CoverImageURL` instead.
    public typealias Cover = String
}
