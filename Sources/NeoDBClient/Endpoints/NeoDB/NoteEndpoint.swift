//
//  NoteEndpoint.swift
//  NeoDBKit
//
//  Created by 甜檸Citron(lcandy2) on 10/12/25.
//  Copyright © 2025 https://github.com/lcandy2. All Rights Reserved.
//

import Foundation
import NeoDBModels

/// API endpoints for creating, reading, updating, and deleting notes
/// associated with items for the authenticated user.
///
/// Conforms to `NetworkEndpoint` to provide path, method, query parameters,
/// and request body payloads.
public enum NoteEndpoint {
    /// Retrieves paged notes for a given item.
    /// - Parameters:
    ///   - itemUUID: Identifier of the item whose notes to fetch.
    ///   - page: Page index starting at 1. Defaults to 1.
    ///   - pageSize: Optional page size override.
    case get(itemUUID: ItemUUID, page: Int = 1, pageSize: Int? = nil)

    /// Creates a new note for the specified item.
    /// - Parameters:
    ///   - itemUUID: Identifier of the target item.
    ///   - noteIn: Payload describing the note to create.
    case create(itemUUID: ItemUUID, noteIn: NoteInSchema)

    /// Updates an existing note by UUID.
    /// - Parameters:
    ///   - noteUUID: Identifier of the note to update.
    ///   - noteIn: Updated note payload.
    case update(noteUUID: NoteAttributes.UUID, noteIn: NoteInSchema)

    /// Deletes a note by UUID.
    /// - Parameter noteUUID: Identifier of the note to delete.
    case delete(noteUUID: NoteAttributes.UUID)
}

extension NoteEndpoint: NetworkEndpoint {
    /// Endpoint target type (API base).
    public var type: EndpointType {
        return .api
    }

    /// Relative request path for the current endpoint case.
    public var path: String {
        switch self {
        case .get(let itemUUID, _, _), .create(let itemUUID, _):
            return "/me/note/item/\(itemUUID)"
        case .update(let noteUUID, _), .delete(let noteUUID):
            return "/me/note/\(noteUUID)"
        }
    }

    /// HTTP method for the current endpoint case.
    public var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }

    /// Query parameters to attach to the request, if any.
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .get(_, let page, let pageSize):
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
        case .create(_, let noteIn), .update(_, let noteIn):
            return noteIn
        default:
            return nil
        }
    }
}
