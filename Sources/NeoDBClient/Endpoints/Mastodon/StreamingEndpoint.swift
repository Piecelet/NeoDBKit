//
//  StreamingEndpoint.swift
//  NeoDBKit
//
//  Created by citron on 1/22/25.
//

import Foundation

public enum StreamingEndpoint: NetworkEndpoint {
    case streaming
    
    public var path: String {
        switch self {
        case .streaming:
            return "/v1/streaming"
        }
    }
} 
