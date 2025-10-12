//
//  CollectionEndpoint.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation
import NeoDBModels

/// API endpoints for managing user collections and their items.
///
/// Provides list and CRUD operations under the authenticated user's scope,
/// and supports fetching items from either user or public collections.
/// Conforms to `NetworkEndpoint` to supply path, method, query, and body.
public enum CollectionEndpoint {
    /// Lists collections owned by the authenticated user.
    /// - Parameters:
    ///   - page: Page index starting at 1. Defaults to 1.
    ///   - pageSize: Optional page size override.
    case list(page: Int = 1, pageSize: Int? = nil)

    /// Creates a new collection under the authenticated user.
    /// - Parameter collectionIn: Payload describing the collection to create.
    case create(collectionIn: CollectionIn)

    /// Retrieves a collection by UUID.
    /// - Parameters:
    ///   - uuid: Collection identifier.
    ///   - isUser: When true, fetches from the user's scope (`/me/…`);
    ///             when false, fetches a public collection (`/collection/…`).
    case get(uuid: CollectionAttributes.UUID, isUser: Bool = false)

    /// Updates a collection by UUID in the authenticated user's scope.
    /// - Parameters:
    ///   - uuid: Collection identifier.
    ///   - collectionIn: Updated collection payload.
    case update(uuid: CollectionAttributes.UUID, collectionIn: CollectionIn)

    /// Deletes a collection by UUID in the authenticated user's scope.
    /// - Parameter uuid: Collection identifier.
    case delete(uuid: CollectionAttributes.UUID)

    /// Lists items contained in the specified collection.
    /// - Parameters:
    ///   - uuid: Collection identifier.
    ///   - isUser: When true, lists from the user's scope (`/me/…`);
    ///             when false, lists a public collection's items.
    ///   - page: Page index starting at 1. Defaults to 1.
    ///   - pageSize: Optional page size override.
    case itemGet(
        uuid: CollectionAttributes.UUID,
        isUser: Bool = false,
        page: Int = 1,
        pageSize: Int? = nil
    )

    /// Adds an item to the specified collection in the user's scope.
    /// - Parameters:
    ///   - uuid: Target collection identifier.
    ///   - collectionInItem: Item payload to add to the collection.
    case itemAdd(
        uuid: CollectionAttributes.UUID,
        collectionInItem: CollectionIn.Item
    )

    /// Removes an item from the specified collection in the user's scope.
    /// - Parameters:
    ///   - uuid: Target collection identifier.
    ///   - itemUUID: Identifier of the item to remove.
    case itemRemove(uuid: CollectionAttributes.UUID, itemUUID: ItemUUID)
}

extension CollectionEndpoint: NetworkEndpoint {
    /// Endpoint target type (API base).
    public var type: EndpointType {
        return .api
    }

    /// Relative request path for the current endpoint case.
    public var path: String {
        switch self {
        case .list:
            return "/me/collection"
        case .create:
            return "/me/collection"
        case .get(let uuid, let isUser):
            return isUser ? "/me/collection/\(uuid)" : "/collection/\(uuid)"
        case .update(let uuid, _):
            return "/me/collection/\(uuid)"
        case .delete(let uuid):
            return "/me/collection/\(uuid)"
        case .itemGet(let uuid, let isUser, _, _):
            return isUser
                ? "/me/collection/\(uuid)/item" : "/collection/\(uuid)/item"
        case .itemAdd(let uuid, _):
            return "/me/collection/\(uuid)/item"
        case .itemRemove(let uuid, let itemUUID):
            return "/me/collection/\(uuid)/item/\(itemUUID)"
        }
    }

    /// HTTP method for the current endpoint case.
    public var method: HTTPMethod {
        switch self {
        case .list, .get, .itemGet:
            return .get
        case .create, .update, .itemAdd:
            return .post
        case .delete, .itemRemove:
            return .delete
        }
    }

    /// Query parameters to attach to the request, if any.
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .list(let page, let pageSize):
            var params: [URLQueryItem] = [.init(name: "page", value: "\(page)")]
            if let pageSize {
                params.append(.init(name: "page_size", value: "\(pageSize)"))
            }
            return params
        case .itemGet(_, _, let page, let pageSize):
            var params: [URLQueryItem] = [.init(name: "page", value: "\(page)")]
            if let pageSize {
                params.append(.init(name: "page_size", value: "\(pageSize)"))
            }
            return params
        default:
            return nil
        }
    }

    /// JSON-encodable body payload for the request, if required.
    public var bodyJson: Encodable? {
        switch self {
        case .create(let collectionIn):
            return collectionIn
        case .update(_, let collectionIn):
            return collectionIn
        case .itemAdd(_, let collectionInItem):
            return collectionInItem
        default:
            return nil
        }
    }
}
